From: Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Subject: "invalid operand 0000" with recent ACPI patches
Date: Mon, 10 Feb 2003 11:11:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E477AD3.30302@gkec.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000201060306010702020103"
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

This is a multi-part message in MIME format.
--------------000201060306010702020103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I'm running kernel 2.4.21-pre[34] with the latest ACPI patch(es). The problem I'm witnessing is pretty annoying:

The kernel produces rather heavy errors (invalid operand 0000), I've attached the log entries (those that look different). This happens relatively often (but not always) on specific ACPI events. It usually happens when I plug out the ac adapter, i.e. when switching to battery power. It sometimes happens when I call the BIOS driven onscreen status display (showing battery power, ac status etc.) which also produces an ACPI event (the interrupt counter increases). The symptoms are really annoying: It simply kills my keyboard. I can sync and reboot using SysRq, and when I'm running X, I can use the mouse to shut down the system. But I can't type and can't switch consoles or anything.

It is quite possible that I actually messed up my DSDT when trying to fix it (though it generally works rather fine). But I can reproduce the same (or similar) problem with the original DSDT - though it seems less likely to occur. That's maybe because the original DSDT doesn't allow the kernel to detect and use the ac and battery status properly, so maybe it simply doesn't try to react on those events. Therefore I'm perfectly willing to believe that there's still a bug hidden somewhere in the DSDT that leads to this. My DSDT is here: http://www.behnel.de/samsung-acpi.html

Since I'm not that used to kernel debugging, the syslog entries do not tell me much. I took a look at one of the functions where an error occurred, but I didn't see anything sufficiently suspicious to make me wonder. Maybe there is something like an interrupt problem? I tried 2.5.59 to see if a preemptive kernel helps, but it doesn't even boot on my machine. So I wasn't able to run any tests with it.

Any hints from anyone?

Thanks in advance,
Stefan :)

--------------000201060306010702020103
Content-Type: application/x-gunzip;
 name="oops.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="oops.log.gz"

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
--------------000201060306010702020103--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
