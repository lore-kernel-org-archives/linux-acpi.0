From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 14:03:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031121130307.GM32464@poupinou.org>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org> <3FBDEFB3.3060303@pca.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qbvjkv9qwOGw/5Fx"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FBDEFB3.3060303-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2003 at 11:57:55AM +0100, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> on 11/21/03 11:12, Ducrot Bruno wrote:
> | I'm using laptop-mode which is now in linux-2.4 since 2.4.23-pre7.
> | You should really look at.  Look at linux/Documentation/laptop-mode.txt
> | for more details.
> sorry, I read the doc but I couldn't found all the info I need... :-(
> 
> ~From the doc above...
> | The main knob is /proc/sys/vm/laptop_mode. Setting that to 1 switches the
> | vm (and block layer) to laptop mode. Leaving it to 0 makes the kernel work
> | like before. When in laptop mode, you also want to extend the intervals
> | desribed above. See the laptop-mode.sh script for how to do that.
> 1) As I understood, to enable 'laptop_mode' I just need to do an
> 	echo 1 > /proc/sys/vm/laptop_mode
> right? I mean, it's already present in the kernel, I don't need to
> enable any new features in kernel config or somewhere else, right?

No need to add a config.  But just echoing to the laptop sysctl is not
engough though.  You have to tweak other VM stuff for it to be fully
functional.

> 2) Where I can find 'laptop-mode.sh'??? It's not present in kernel
> source dir...

Ah, hem, that seems to be missing...  Here is the orignal one posted,
or from a link (I don't remember) to LKML.
I use it with another script to handle AC change via acpid.
It is also called with 'stop' on shutdwon, or reboot.


Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=laptop-mode

#!/bin/sh
#
# start of stop laptop mode, best run by a power management daemon when
# ac gets connected/disconnected from a laptop
#
# FIXME: assumes HZ == 100

# age time, in seconds. should be put into a sysconfig file
MAX_AGE=600

# kernel default dirty buffer age
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
		echo "."
		;;
	stop)
		U_AGE=$((100*$DEF_UPDATE))
		B_AGE=$((100*$DEF_AGE))
		echo -n "Stopping laptop mode"
		echo "0" > /proc/sys/vm/laptop_mode
		echo "30 500 0 0 $U_AGE $B_AGE 60 20 0" > /proc/sys/vm/bdflush
		echo "."
		;;
	*)
		echo "$0 {start|stop}"
		;;

esac

exit 0

--Qbvjkv9qwOGw/5Fx--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
