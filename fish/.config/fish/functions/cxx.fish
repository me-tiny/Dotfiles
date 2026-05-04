function cxx -a file -d "compile and run with clang++"
    if not test -f "$file"; or not test (path extension "$file") = ".cpp";
        echo "need .cpp file to compile and run"
        return 1
    end
    set output (path change-extension ".o" $file)
    set command "clang++ -std=c++11 -O3 -DNDEBUG $file -o $output"
    if eval $command
        ./$output
    else
        echo "build failed"
        return 1
    end
end
