# nf-cloud-reports

Minimal Nextflow pipeline for testing Seqera Platform run reports when `--outdir` points at cloud storage (`s3://`, `gs://`, `az://`).

It publishes:

- `multiqc/multiqc_report.html`: an HTML report that loads a sibling `style.css` by relative path
- `summary.csv`: a small table

Both are declared as reports in `tower.yml`. No containers are needed.

```bash
nextflow run swingingsimian/nf-cloud-reports -r grid-ce-cloud-outdir --outdir s3://<bucket>/<prefix>
```
