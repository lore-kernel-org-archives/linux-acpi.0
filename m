From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 13:13:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031121111323.GB18223@luna.mooo.com>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031121101232.GL32464-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2003 at 11:12:32AM +0100, Ducrot Bruno wrote:
> On Fri, Nov 21, 2003 at 12:01:03PM +0800, Ow Mun Heng wrote:
> > Hi,
> > 
> > 	This is a question (not a solution) to determine how to gain maximum
> > batt life on a laptop.
> > 
> > More details on http://bellet.info/~bellet/laptop/t40.html
> > 
> > Currently, following the recommendations in the link above, I have set
> > 'noatime' for my HDs as well as placing commit=600.
> > 
> > so in /etc/fstab
> > 
> > /dev/hda	/	etx3	defaults,noatime,commit=600 1 1
> > 
> > The commit=600 is supposed to stop Kjournal from committing to disk every 5
> > seconds and to give a chance to the HD to spin down (not happening!) (can
> > check via hdparm -C /dev/hda)
> > 
> > Doing a hdparm -y /dev/hda (to place the disk into standby) will only work
> > for like 10-30 seconds before it spins up again. I have no idea what is
> > causing it to spin up again.. (what I/O is going on??)
> > 
> > There is the option of changing bdflush as well, changing this (5th & 6th)
> > to 6000 & 12000 does not yield anything better
> > 
> 
> I'm using laptop-mode which is now in linux-2.4 since 2.4.23-pre7.
> You should really look at.  Look at linux/Documentation/laptop-mode.txt
> for more details.
>

like said here, laptopmode is what you want since it holds back dirty
buffer flushes which is what you are experiencing. It will fire up the
disk on reads though. I attached a script that you can use to enter
laptopmode (was actually distributed with laptopmode as far as I could
tell when googling for the original patch). I call it in responce to
ac events from acpid to get it running when the power is disconnected.
Will have to make sure that you get those event though since I had to
twik my dsdt for that.
You can also look at cpufreq of acpi cpu throttling to throttle down you
cpu when on battery to conserve power (assuming you cpu supports that).
I patched reiserfs to change the journal commit time according to the entry in
bdflush so that I can get the regular 30 sec journal flush time when on
ac and 10 minutes when of battery.
I could try making such a patch for ext3 if you want.

> 
> -- 
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=laptopmode_script

#!/bin/sh
# start or stop laptop mode. best run by a power management daemon when ac gets
# connected/disconnected from a laptop.

# FIXME : assumes HZ * <age time in seconds> (HZ = 100). should be put into a
# sysconfig file

# The dirty buffer age and update time when running on laptop mode
MAX_AGE=600

# The kernel's default dirty buffer age and update time
DEF_AGE=30
DEF_UPDATE=5

if [ ! -w /proc/sys/vm/laptop_mode ]; then
    echo "Kernel is not patched with laptop_mode patch"
    exit 1
fi

case "$1" in
start)
    AGE=$((100*$MAX_AGE))

    echo -n "Starting laptop mode"
    echo "1" > /proc/sys/vm/laptop_mode
    echo "30 500 0 0 $AGE $AGE 60 20 0" > /proc/sys/vm/bdflush

    # if no AAM support, manually set spin down
    if [ ! -d /proc/aam/hda ]; then
	hdparm -S6 /dev/hda
    else
	echo 1 > /proc/aam/hda/enabled
    fi

    echo ".";;

stop)
    U_AGE=$((100*$DEF_UPDATE))
    B_AGE=$((100*$DEF_AGE))

    echo -n "Stopping laptop mode"
    echo "0" > /proc/sys/vm/laptop_mode
    echo "30 500 0 0 $U_AGE $B_AGE 60 20 0" > /proc/sys/vm/bdflush

    # Disable spin down
    if [ ! -d /proc/aam/hda ]; then
	hdparm -S0 /dev/hda
    else
	echo 0 > /proc/aam/hda/enabled
    fi

    echo ".";;

*)
    echo "$0 {start|stop }";;

esac
exit 0


--IS0zKkzwUGydFO0o--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
