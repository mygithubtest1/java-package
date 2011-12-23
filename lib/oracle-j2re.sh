# Detect product
function oracle_j2re_detect() {
  local found=
  
  case "${DEB_BUILD_ARCH:-$DEB_BUILD_GNU_TYPE}" in
    i386|i486-linux-gnu)
      case "$archive_name" in
      esac
      ;;
    amd64|x86_64-linux-gnu)
      case "$archive_name" in
	"jre-7u"[0-9]"-linux-x64.tar.gz") # SUPPORTED
	    j2se_version=1.7.0+update${archive_name:6:1}${revision}
	    j2se_expected_min_size=88 #Mb
	    found=true
	    ;;
      esac
      ;;
  esac
  if [[ -n "$found" ]]; then
	cat << EOF

Detected product:
    Java(TM) Runtime Environment (JRE)
    Standard Edition, Version $j2se_version
    Oracle Microsystems(TM), Inc.
EOF
	if read_yn "Is this correct [Y/n]: "; then
	    j2se_found=true
	    j2se_release="${j2se_version:0:3}"
	    j2se_required_space=$(( $j2se_expected_min_size * 2 + 20 ))
	    j2se_vendor="oracle"
	    j2se_title="Java(TM) JRE, Standard Edition, Oracle Microsystems(TM)"
	    j2re_run
	fi
    fi
}

j2se_detect_oracle_j2re=oracle_j2re_detect
