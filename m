From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: 2.5.39 Insomniac, any first dbg?
Date: Mon, 30 Sep 2002 15:41:47 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209301541.47910.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, 
I 've compiled 2.5.39 (since Sat.) and it is Insomniac (can't sleep). When I 
'echo [1|4] > /proc/acpi/sleep',  nothing gets logged and nothing happens.
I also tried S2, the system re-booted (after hard lock).
Do you have any first dbg comments? Where should I start debugging from?

Details:
2.5.39 on HP Xe3 GC
kernel: uni-proc, APIC, IO-APIC (don't work, I think, but are compiled in).
ACPI: 20020918, all enabled, also tried with 'debug statements' set. It 
reports it can do S0,1,2,3,4,5 ..

I echo to /proc/acpi/sleep. Nothing happens, nothing gets logged for 1,4.
I looked into kernel/suspend.c and acpi/sleep.c . Which fn's can cause the 
sleep procedure to fail w/o notices?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
