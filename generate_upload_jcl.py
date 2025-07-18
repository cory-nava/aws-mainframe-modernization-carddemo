import os

def generate_jcl_for_file(file_path, source_type):
    file_name = os.path.basename(file_path)
    member_name = os.path.splitext(file_name)[0].upper() # Member names are uppercase, no extension

    if source_type == 'bms':
        pds_name = 'HERC01.CARDDEMO.BMS'
        job_name = 'BMSUPL'
        job_desc = 'UPLOAD BMS MAP'
    elif source_type == 'cbl':
        pds_name = 'HERC01.CARDDEMO.CBL'
        job_name = 'CBLUPL'
        job_desc = 'UPLOAD COBOL PROG'
    elif source_type == 'cpy':
        pds_name = 'HERC01.CARDDEMO.CPY'
        job_name = 'CPYUPL'
        job_desc = 'UPLOAD COPYBOOK'
    else:
        raise ValueError(f"Unknown source type: {source_type}")

    with open(file_path, 'r') as f:
        source_content = f.read()

    # Escape single quotes in the source content for JCL
    escaped_source_content = source_content.replace("'", "''")

    jcl_content = f"""//HERC01A JOB (ACCT),'{job_desc}',CLASS=A,MSGCLASS=A,NOTIFY=HERC01
//STEP1    EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSUT2   DD DSN={pds_name}({member_name}),DISP=(NEW,CATLG,DELETE),
//            UNIT=SYSDA,SPACE=(TRK,(1,1,1)),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120)
//SYSUT1   DD *
{escaped_source_content}
/*
//
"""
    return jcl_content, f"UPLOAD{member_name}.jcl"

def main():
    base_dir = os.getcwd() # Current working directory is the repo root
    upload_jcl_dir = os.path.join(base_dir, 'app', 'jcl', 'upload_src')
    os.makedirs(upload_jcl_dir, exist_ok=True)

    source_dirs = {
        'bms': os.path.join(base_dir, 'app', 'bms'),
        'cbl': os.path.join(base_dir, 'app', 'cbl'),
        'cpy': os.path.join(base_dir, 'app', 'cpy')
    }

    for source_type, dir_path in source_dirs.items():
        for root, _, files in os.walk(dir_path):
            for file_name in files:
                if file_name.endswith(f".{source_type}") or file_name.endswith(f".{source_type.upper()}"):
                    file_path = os.path.join(root, file_name)
                    jcl_content, jcl_file_name = generate_jcl_for_file(file_path, source_type)
                    
                    output_jcl_path = os.path.join(upload_jcl_dir, jcl_file_name)
                    with open(output_jcl_path, 'w') as f:
                        f.write(jcl_content)
                    print(f"Generated JCL for {file_name} at {output_jcl_path}")

if __name__ == "__main__":
    main()
