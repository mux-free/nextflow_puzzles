#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// README:
/* The goal is to make a soup by combinng all inputed veggi weights and adding "water" weight

Input: veggie.csv with a veggie name per row and its weight
Output: text file with "soup_type weight". */

workflow {

    ch_fruit = Channel.fromPath("fruits.csv")
    ch_taste = Channel.fromPath("taste.csv").splitCsv()

    ch_fruit
        .splitCsv()
        // .subscribe { println "$it"} // very similar to .view, but with "subscribe" we can put different operations inside the curly brackets!
        .combine(ch_taste)
        .view()
        //.set { ch_fruit_tastes } // creating a channel so that we can referr to it later
        .collectFile(name: "fruit-taste-combinations.txt", storeDir : '.') { it1, it2 ->
        [ "fruit-taste-combinations.txt", it1 + " " + it2 + '\n' ]}
        .view()
}