From: Michael Grigoriev <mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org>
Subject: Standby (S1) does not work
Date: Sun, 06 Jun 2004 15:05:10 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.06.06.15.05.09.196978@luminal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I am running 2.6.7-rc2-mm2 on an HP zt3000 series (centrino based)
notebook. The problem is I can't seem to get normal standby (S1) working.

When I echo "1" into /proc/acpi/sleep or "standby" into /sys/power/state,
the screen blanks for a second but comes right back (and yes, I tried
delaying it with a sleep, and using echo -n). The dmesg shows:

PM: Preparing system for suspend
Stopping tasks: ================|
Restarting tasks... done

Same thing happens under X and with a very minimal kernel from the console.

In possibly related news, I noticed this abnormality:

# cat /sys/power/state
standby mem disk

# cat /proc/acpi/sleep
S0 S3 S4 S4bios S5

Notice that proc does not even list S1!

I was able to get suspend to disk kind of working, so not *everything* is
broken :)

I'd be happy to provide more info about my system, etc, but I'd even
appreciate some pointers as per how I can debug this... I've done a bit of
kernel development in the past, but nothing related to pm/acpi, so I'm
kind of clueless here. For example, I compiled a kernel with acpi debug
info, but that did not seem to give me any more messages. Is there
something special I need to do to actually change the debug level?

Oh a couple more questions while I am here:

1. Sometimes my system goes into a state where even holding the power
button down for a while does not turn it off - I have to pop out the
battery to reboot it (my broken wireless driver sometimes causes this, and
so does trying to suspend to ram). Is this also an ACPI problem, or should
this be handled entirely in hardware?

2. What does S4bios mean? I am assuming it somehow has the BIOS restore
the RAM image rather than having to boot up the kernel to do it, so it's
faster? How can I actually use this mode? Are there any docs anywhere?

Thanks in advance!

-- 
Have fun,
Michael "mag" Grigoriev          The words I have, the spells I know,
mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org                     Were not enough to make you happy
http://www.luminal.org                        To make you smile again



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
