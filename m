From: "Michael A. Smith" <mas3f-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: Re: Problems with 600m PM states
Date: Fri, 2 Jan 2004 16:42:42 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.BSF.4.55.0401021635300.503@dea.intranet>
References: <3ACA40606221794F80A5670F0AF15F8401720C6D@PDSMSX403.ccr.corp.intel.com>
 <Pine.BSF.4.55.0401021139340.70212@dea.intranet> <20040102185613.GA30051@hell.org.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040102185613.GA30051-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2 Jan 2004, Karol Kozimor wrote:

> Thus wrote Michael A. Smith:

> > The system seems to suspend correctly, but will not resume.  After the
> > suspend, the power led has a slow blink, which is what I expect.  If I
> > hit the power button to bring it back, I can hear the disk spin up, and
> > the power led is on full, but that's it.  The screen never returns and
> > my only recourse is a hard reboot.

> Please try 2.6.1-rc1 or -rc1-mm1 for the keyboard problem.

Tried 2.6.1-rc1 (with the S1 patch referenced earlier in the thread)
and see the same behavior for S3.  Not sure which keyboard problem you were
referring to though.

> Have you already tried passing acpi_sleep={s3_mode,s3_bios} as a
> kernel parameter?

I have now.  If I use either, instead of resuming, the machine reboots.
Without any parameter, after resume the screen remains off, but it
appears the system is running ... if i blindly type "shutdown -h now",
the system will power off.

Michael Smith
mas3f-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
