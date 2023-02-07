nextflow.enable.dsl=2

input_ch = Channel.fromPath(params.samples)
    .splitCsv(header: true, sep: "\t", strip: true)
    .map(row -> [row.sample, row.bam])

process rm_chr {
    publishDir "${projectDir}/results", mode: "move"

    input:
        tuple val(sample), path(bam)

    output:
        tuple path(no_chr), path("${no_chr}.bai")

    script:
        no_chr = "${sample}.no_chr.bam"
        
        """
        samtools reheader -c 'perl -pe "s/^(@SQ.*)(\\tSN:)chr/\\\$1\\\$2/"' ${bam} > ${no_chr}
        samtools index -b -@ 4 ${no_chr}
        """
}

workflow {
    rm_chr(input_ch)
}