From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: cvs commit: src/sys/contrib/dev/acpica acfreebsd.h
Date: Wed, 10 Mar 2004 18:26:54 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040310182253.P61709@root.org>
References: <20040303220117.R21587@root.org> <20040309110721.B88330@mail.ncircle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040309110721.B88330-YW38lnafgrALLvduDZEr5g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brian Buchanan <brian-QcaC+sH85HNBDgjK7y7TUQ@public.gmane.org>
Cc: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 9 Mar 2004, Brian Buchanan wrote:
> I hacked the ASL for my ThinkPad T40p so that "FreeBSD" was treated as an
> equivalent to "Windows 2001".  After your change, the Fn+F8 screen
> expansion toggle stopped working.
>
> I've attached the acpidump output you requested.  My local modification
> was to add after the check for "Windows 2001":
>
> If (LEqual (\SCMP (\_OS, "FreeBSD"), Zero))
> {
>     Store (0x02, \WNTF)
> }

The issue is that we don't support the _OSI method yet, otherwise we could
advertise FreeBSD as being both Windows 2k and XP compatible.  Your best
workaround is to just unconditionally store 0x02 into \WNTF at the end of
the \_SB._INI function.  Since the custom AML will only be loaded by
FreeBSD, you won't affect other OS's with this change.

Bob, any word on _OSI implementation?

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
