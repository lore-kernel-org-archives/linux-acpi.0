From: Simon David Foster <s.d.f-FhtRXb7CoQBt1OO0OYaSVA@public.gmane.org>
Subject: Screen not resuming after S3 resume
Date: 04 Oct 2003 22:02:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065301330.2386.11.camel@simon>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I am running 2.6.0-test6 on a Dell Inspiron 4150 (mainly for the better
ACPI support) and ACPI works perfectly out-of-box. However, if I issue
1 or 3 to /proc/acpi/sleep, when I try to resume the screen display does not come
back. I am sure the system has resumed correctly though because when I do
Ctrl-Alt-Del, the system displays all signs of going for restart and
then restarts and I can ssh in. Do I have to issue a command on resume to bring back the
display, and if so how? This happens in both console and XFree86. I have applied
the relevant DSDT from the acpi website for the 4150, but it made no
difference. Actually I did manage to get the screen to come back from a standby
(not a suspend), but immediately after this I tried again and the display wouldn't
come back. I tried unloading the radeon.o module, but it made no difference.

The relevant log portion:

----------
PM: Preparing system for suspend
Stopping tasks: =========================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
Back to C!
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue c1311c00, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks... done
----------

when resuming from S1.

Any help is much appreciated.

-Si



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
