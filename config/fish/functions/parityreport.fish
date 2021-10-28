function parityreport
	if test (count $argv) -lt 1
		echo "Give the pipeline id"
		return
	end
	az pipelines runs artifact download --project mariner --run-id $argv[1]  --path $argv[1]/Reports --artifact-name Reports

end
