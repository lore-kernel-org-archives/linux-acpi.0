From: Brouard Nicolas <nicolas.brouard-TDf4sKD1mxeHlu7OokbhRg@public.gmane.org>
Subject: Kernel 2.6.6 and ACPI s3 resume on Sony Z1
Date: Fri, 21 May 2004 18:21:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085156498.5815.33.camel@localhost>
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

Hi, I am new on this list and sent a first message to the Mandrake
Cooker list. They told me that I coud probably get more information from
ACPI-devel. So here it is:

I made a naive test of kernel 2.6.6.0-rc2 (Mandrake Cooker) in order to
see if
after a successful sleep:
    echo 3 >/proc/acpi/sleep 
the computer would wake up or at least give more informations than with
former kernel version, kernel 2.6.3  (Mandrake 10.0 Official).

Unfortunately, the new kernel patches for ACPI didn't apparently change
anything to the former problem.

On my Sony Z1 laptop, suspend on RAM has always worked : hard disk
stops, screen is getting black, fans are stopped, power is down with a
blinking orange button as on Windows.

But for resume, once you push the button, it turns to permanent yellow
(as it should do) but nothing else, and everything is frozen (no hard
disk starting, no video) and the freeze appears apparently at a very
early stage. 
The only solution is to unplug the battery for a few instants and to
boot again. 

I have read that the resume problem does exist on many laptops. And for
some of them the problem was only a video problem but for the Sonys it
is apparently a very deep problem. Suppressing network and most of the
services before suspending doesn't
change anything.

Some people have tried to make swsusp2 working, more or less
successfully on a Sony, but it requires more than a minute to resume
(when it resumes) which is about the same standard time to boot, so I
don't take this alternative as very useful. On Windows suspend to ram
takes only a few seconds to resume. So why couldn't we do it on Linux?  
Is here any hope to use ACPI S3?

Excepting this resume problem, most of the features of this laptop are
running now (centrino, cpufreq,  fans/heating [through ACPI]) on Sony Z1
laptops.

Is it possible to write to Sony in order to get some information on
their suspend process? Where should I write (Sony did not co-developed
ACPI with Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba but
apparently uses the protocol for their recent laptops)? What kind of
information should I ask? I looked at the official ACPI 2 document
http://www.acpi.info but I haven't been able to understand if there is a
standard protocol for the resume. More precisely, what should I expect
when pushing the power button after an apparently successful resume
(hard disk on, fans on etc)? How can I patch the ASM in order to get any
information? Is there something written somewhere on this subject?
(Because of my poor knowledge in ASM language and even in the kernel
area, I am more trying to get experts working on it than doing it
myself....)

Any information is welcome!

Nicolas Brouard

P:S Mandrake Cooker released kernel-2.6.6.3mdk-1-1mdk.i586.rpm yesterday
but unfortunately it even doesn't boot at all: fans are at the highest
speed and the laptop is overheating rapidly. So we are in the regression
phase.





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
