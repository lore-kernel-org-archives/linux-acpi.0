From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhns-devel] [PATCH 0/6] ACPI based physical cpu hotplug
Date: Mon, 13 Sep 2004 17:23:20 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040913172320.30ca3fc5.tokunaga.keiich@jp.fujitsu.com>
References: <20040908181654.A7287@unix-os.sc.intel.com>
 <20040913024817.000061bb.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20040913024817.000061bb.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 13 Sep 2004 02:48:17 +0900 Keiichiro Tokunaga wrote:
> On Wed, 08 Sep 2004 18:16:54 -0700, Keshavamurthy Anil S wrote:
> > 
> > Hi All,
> > 	As everybody knows that we have logical cpu online/offline support in the kernel, the following set of patches extends this feature to provide ACPI based physical CPU hotplug and I am asking this set of patches to be included in the acpi-test tree. 
> > 
> > Please let me know if anyone see any issues or comments or even flames welcome:). 
> 
> I am attaching user mode agent scripts for container hotplug,
> 'container.agent' and 'acpi_container.agent'.  Please put them
> under /etc/hotplug/ for working the container hotplug.
> 
> 'container.agent' is called by the container driver.  It calls a platform
> specific agent as appropriate.  'acpi_container.agent' is one of the
> platform specific agents and does real works.
> 
> 'acpi_container.agent' does logical hotplug operations like "echo 0 >
> /sys/devices/system/cpu/cpu0/online".  The agent gets an ACPI
> object name of the target container device (e.g. DEV1) as an
> argument, searchs entries of CPUs contained in the container, and
> echos to the entries.  This version supports only CPU for now.

I found a bug in 'acpi_container.agent'.  Here is a fixed version.

  - Fixed the bug in eject_target() function.  It did not return a proper
    string.
  - Replaced a term '/sys' with '$SYSFS_MOUNTPOINT'.

Thanks,
Keiichiro Tokunaga

[acpi_container.agent]
#!/bin/sh
#
# ACPI Container hotplug agent
#
# Kernel params are:
#	
#	ACTION=%s [add or remove]
#	CONTAINER=/sys/...
#
# 10-Sep-2004	Initial version, CPU support
#

TMP=tmp$$
SYSFS_MOUNTPOINT=`mount | grep 'sysfs' | cut -d ' ' -f 3`
CPU_INFO_DIR=/proc/acpi/processor
SYSDEVICES=$SYSFS_MOUNTPOINT/devices/system
CPU_HOTPLUG=$SYSDEVICES/cpu/cpu
MEMBLOCKSIZE=$SYSDEVICES/memory/blocksize
FIRM_DIR=$SYSFS_MOUNTPOINT/firmware/acpi
EJECT_OP=$FIRM_DIR/eject
alias cpus_list='ls $CPU_INFO_DIR'

function cpu_hot_plug()
{
    cpus_list > $TMP
    for cpu_firm in `find $DEV_PATH -type d -print | grep -w -f $TMP` 
      do
      cpuname=`basename $cpu_firm`
      if [ ! -f $CPU_INFO_DIR/$cpuname/info ]
	  then
	  echo "cannot access $CPU_INFO_DIR/$cpuname/info"
	  continue
      fi
      cpuid=`awk '/processor id:/ {print $3}' $CPU_INFO_DIR/$cpuname/info`
      if [ ! -f ${CPU_HOTPLUG}${cpuid}/online ]
	  then
	  echo "cannot access ${CPU_HOTPLUG}${cpuid}/online"
	  continue
      fi
      onlined=`cat ${CPU_HOTPLUG}${cpuid}/online`
      if [ $onlined == "0" ]
	  then
	  contine;
      fi
      echo $CPU_HOTPLUG_CODE > ${CPU_HOTPLUG}${cpuid}/online
      if [ $? != 0 ]
	  then
	  echo "cpu$cpuid hotplug failed."
	  ERROR=1
      fi
    done 
}

function eject_target()
{
    TARGET=`echo $DEV_PATH | sed "1s?${SYSFS_MOUNTPOINT}??" | sed '1s/\/firmware\/acpi\/namespace\/ACPI\/_SB\///' | sed '1s/\//\./g'`
    echo \\_SB_.$TARGET
}

function usage()
{
    echo "Usage : acpi_container.agent (-t target-device-name| -p CONTAINER) (add|remove)"
    exit 2
}


#
# Main routine
#
set -- `getopt p:t: $*`
if [ $? != 0 ]
then
    usage
fi

while [ $1 != -- ]
do
  case $1 in
      -t) shift; DEV_PATH=$SYSFS_MOUNTPOINT/firmware/acpi/namespace/ACPI/_SB/$1;;
      -p) shift; DEV_PATH=$1;;
  esac
  shift;
done
test=`eject_target`

shift;
act=$1

ERROR=0

case $act in
    add)
	CPU_HOTPLUG_CODE="1"

	cpu_hot_plug
	;;

    remove)
	CPU_HOTPLUG_CODE="0"

	cpu_hot_plug

	# eject operation
	if [ $ERROR == 0 ]; then
	    target=`eject_target` 
	    echo $target > $EJECT_OP
	    if [ $? != 0 ]; then
		echo "Failed to eject device($target)."
		ERROR=1
	    fi
	fi
	;;
esac

rm -f $TMP > /dev/null 2>&1 

exit $ERROR


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
