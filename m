From: "Sander Wichers" <wichers-Jdbf3xiKgS8@public.gmane.org>
Subject: High pitch noise produced when ACPI processor module loaded
Date: Fri, 26 Sep 2003 09:59:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <001001c38404$27b959a0$2001a8c0@silverstone>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hi,

My inspiron 8600 (intel centrino/855PM) is producing a strange high pitch
sound which comes from within the machine (definitly not the speakers) when
the acpi processor module get's loaded. When I unload the processor module
the high pitch sound goes away.

Luckily I'm not the only with a dell inspiron having this problem. So far
I've seen bug reports from people with an inspiron 8x00 / and lattitude C840
/ C600 series:
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/index.html#2247
http://www.ussg.iu.edu/hypermail/linux/kernel/0305.1/index.html#628

The workarounds displayed in the links above don't do anything with the real
problem....

I've tried to turn of frequency scaling, this doesn't influence anything. I
also tried the apm workaround > no luck either. (apm isn't supported in my
bios)

This isn't normal behavior, is it? The noise is very annoying, it makes you
not want to sit behind the machine! Is there a workaround for this?

thanks,

Sander



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
