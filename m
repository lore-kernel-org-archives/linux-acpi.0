From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [Fwd: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook (contains agp, lapic, swsusp)]
Date: Sun, 15 Feb 2004 20:36:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040215193630.GB14083@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F8401CBB68A@PDSMSX403.ccr.corp.intel.com> <20040211105531.GA30647@hell.org.pl> <20040211110154.GJ12634@redhat.com> <20040211112505.GE30647@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040211112505.GE30647-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>, sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Karol Kozimor:
> 				pmdisk	swsusp	swsusp2
> intel-agp not loaded		OK	OK	OK
> intel-agp loaded, not in use	(?)	reboot	OK
> intel-agp in use		reboot	reboot	OK
> 

It seems I have rushed a bit with that declaration (I'm not using 2.6 on a
regular basis due to lack of USB PM) -- suspending and resuming with
intel-agp used is quite unstable, even with swsusp2. What probably happens
is that it suspends when the X is started for the first time, but any VT
switch will make it reboot. I'll try to verify that in the following days.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
