From: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Subject: Sony Vaio, S4bios and bios version
Date: Sat, 1 Mar 2003 09:52:11 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.50.0303010935340.1274-100000@flyby>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi all,

I have a Sony Vaio PCG-FX601 (FXA53 for USA) and I'm still not able to
make S4bios to work.
I tested any acpi patch for 2.4.x kernels and many for 2.5.x ones, but
for all of them I got the same behavior: after resume phase, notebook
hangs and the bios resume screen remains on display forever.
I'll try new 2.5.63 acpi patch soon, hoping it works :)
I tried FreeBSD 5.0 too, with same bad result.
Yes, I have an A0 suspend partition and suspend-to-disk works great with
APM.

My notebook has R0115K5 bios version. Is there anybody with vaio
FX-[5678]0x with newer bios version (R0118K5 or R0121K5) that made
S4bios to work?

Thanks.

--
Regards,  Marco Gigante


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
