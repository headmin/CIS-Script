# Creation date CISBenchmarkReport
echo >> "${CISBenchmarkReport}"
echo "Security report - $(date -u)" >> "${CISBenchmarkReport}"

open "${CISBenchmarkReportPath}"
# open -a Numbers "${CISBenchmarkReport}"
# open -a "Microsoft Excel" "${CISBenchmarkReport}"