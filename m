From: Paul Richards <pauldoo-uGgzU+OBInnR7s880joybQ@public.gmane.org>
Subject: VAIO PCG-GR414SP no battery status report
Date: Mon, 5 Aug 2002 15:09:45 +0100 (BST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0208051502350.16260-100000@purple>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I have the above laptop and with kernels 2.4.18 and 2.4.19 there is no
battery status report in /proc/apm or /proc/acpi/battery when compiled
with APM or ACPI respectively..

I have been looking on the internet for hints as to what is wrong but I
can't find much...

First question..  Is ACPI in 2.5.x better..?  Should I be using that
kernel?

Second question, I have experience with C/C++ but have never done kernel
programming, how hard is it (usually) to add support for a new chipset..?
I have had some fairly grizzly sessions with gdb..  Will I get to re-live
those memories?  :)

One last thing..  with ACPI in .4.19 I get a lot of stuff in dmesg about
things not loading/working, but in .4.18 I don't get them..

Could these be relevant..?  Should I post them?

Thanks very much in advance, I am genuinely willing to knuckle down and
code something, if someone could point out to me what needs to be patched.

-- 
Paul Richards



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
