From: Philip Balister <philip-6RQC9ztksjxg9hUCZPvPmw@public.gmane.org>
Subject: S3 on Dell D600
Date: Tue, 25 May 2004 12:49:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085503783.3837.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

I've been trying to get my Dell D600 laptop to sleep using echo 3
>/proc/acpi/S3. I am closer than I have been, the current problem is
the laptop suspends and immediately restarts. I am running FC2 with
kernel rpm version 2.6.6-1.377.

I do unload the the tg3 ethernet driver module and the ipw2100 wireless
module. If I don't the system hangs apparently during the loading of the
ipw2100 firmware.

Here is the results of dmesg:

PM: Preparing system for suspend
Stopping tasks:
======================================================================================|
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PCI: Setting latency timer of device 0000:00:1f.5 to 64
drivers/acpi/osl.c:737: spin_lock(drivers/acpi/osl.c:11f37804) already
locked by drivers/acpi/osl.c/737
drivers/acpi/osl.c:756: spin_unlock(drivers/acpi/osl.c:11f37804) not
locked
Restarting tasks... done
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode

Anyone have any more suggestions? Do I need to hunt down the exact
version of acpi in this kernel?

Thanks,

Philip



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
