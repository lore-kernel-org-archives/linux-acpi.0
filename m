From: mjreed-u5kTQ1pR2sj10XsdtD+oqA@public.gmane.org
Subject: suspend/resume under S3 (radeon), fine under AC, not under battery
Date: Mon, 17 May 2004 10:38:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16552.34867.548653.781933@mjrinsp.essex.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi,

I have an (almost) working S3 with video on a radeon M7 LW (Mobility
7500) with linux 2.6.5 (gentoo dev sources), I realise I am _very_
lucky to get this far. To get it working I have had to load and use
radeon dri modules (radeon, intel_agp, agpart). Without DRI enabled it
resumes with garbage video. I have not done exhaustive testing but it
managed a few suspend-resume S3 cycles under power OK.

However, although S3 works fine under AC (both for
suspend/resume S3) when suspending (echo 3 > /proc/acpi/sleep) under
battery power and returning under battery power the video is not
coming up (just garbage lines). 

I was wondering what could be different under battery power, is it
anything that can be tweaked under ACPI/linux or is it just likely to
be some hardware problem that is not so easy to solve?

(I had a similar problem with the ACPI event code and swsusp2 S4
suspend/resume cycles under 2.4 for a while but this went away after
various ACPI/kernel patches).

I have a working S4 swsusp2 so I guess that other components are
installed OK for PM.

Martin
--
Dr. M.J. Reed                               Room:          4SB.6.15
Dept. Electronic Systems Engineering         Tel:+44 (0)1206 872479
University of Essex, Colchester CO4 3SQ, UK  FAX:+44 (0)1206 872900
Email mjreed (non Essex users should add @essex.ac.uk)
Web: http://esewww.essex.ac.uk/~mjreed


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
