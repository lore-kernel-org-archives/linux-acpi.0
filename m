From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: problems with acpi (sleep states) on vaio notebook z1sp
Date: Wed, 24 Dec 2003 23:42:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031224224236.GA25026@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F8401720C50@PDSMSX403.ccr.corp.intel.com> <1072201432.3134.10.camel@garrett.darkzone> <20031224153617.GI1632@luna.mooo.com> <3FE9DA42.1050909@psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FE9DA42.1050909-8DAjSxpRXgY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nirmal Govind <nirmalg-8DAjSxpRXgY@public.gmane.org>
Cc: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Nirmal Govind:
> Looks like there are a few of us who have the same problem.. what 
> error messages do you get in syslog? If we're all getting similar 
> error messages then that may narrow down the problem for the 
> developers..

What's likely is that you're hitting several problems at once:
1) display reinit: if acpi_sleep=s3_{bios,mode} at boot doesn't help, I
   don't know what does,
2) keyboard / mouse (touchpad) dead: apply the patches found here [1]
   against a vanilla 2.6.0, should fix it once and for all,
3) uhci-hcd's appalling PM / suspend / resume support -- a workaround is to
   unload all USB drivers prior to suspend.

Judging by the fact that you have something written in syslog after resume,
it seems you're not so far from having S3 working, the video adapter being
the most important issue.

[1] http://www.geocities.com/dt_or/input/

Best regards, hope that helps you.

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
