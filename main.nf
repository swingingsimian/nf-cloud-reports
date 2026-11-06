nextflow.enable.dsl = 2

params.outdir = 'results'

process MAKE_REPORTS {
    publishDir params.outdir, mode: 'copy'

    output:
    path 'multiqc/*'
    path 'summary.csv'

    script:
    """
    mkdir -p multiqc
    cat > multiqc/style.css <<'CSS'
    body { font-family: sans-serif; background: #f4f8fb; }
    h1 { color: #160f26; border-bottom: 3px solid #0dc09d; }
    .ok { color: #0dc09d; font-weight: bold; }
    CSS

    cat > multiqc/multiqc_report.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <title>Cloud outdir report</title>
      <link rel="stylesheet" href="style.css">
    </head>
    <body>
      <h1>Cloud outdir report</h1>
      <p class="ok">If this text is green, the sibling style.css loaded too.</p>
      <p>Generated on HOST at TIME.</p>
    </body>
    </html>
    HTML
    sed -i.bak "s/HOST/\$(hostname)/; s/TIME/\$(date -u +%Y-%m-%dT%H:%M:%SZ)/" multiqc/multiqc_report.html && rm multiqc/multiqc_report.html.bak

    printf 'sample,reads,status\\nA,1200,pass\\nB,980,pass\\nC,40,fail\\n' > summary.csv
    """
}

workflow {
    MAKE_REPORTS()
}
