From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: Network failures with ACPI enabled (kernel 2.4, 2.6)
 PROBLEM FOUND!!!!!!
Date: Wed, 31 Dec 2003 15:46:41 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031231152704.A3006@root.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8953@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8953-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Dec 2003, Brown, Len wrote:
> > You won't believe me but I found out what was causing the problem.
> > Since I never use the parallel port on this notebook I turned
> > it OFF in the BIOS.
> > Setting it to AUTOMATIC mode solved my issues.
>
> > The Linux-ACPI still has a problem somewhere since I don't see the
> > network timeouts in WinXP, if I turn off the parport.
> > For me it looks like that the parport and the internal card share
> > something, either ACPI or hardware wise and by turning off the parport
> > the network card somehow changes too.
>
> It may be I/O port ranges rather than IRQs at the bottom of this one.

You can use the -r flag for acpidump to decode Buffers as
ResourceTemplate()s:

     -r   Additionally outputs commented ResourceTemplate() macros for
	  Buffer objects that contain valid resource streams.  These macros
	  are defined in the ACPI 2.0 specification section 16.2.4.

Since moving to iasl as the acpidump backend in FreeBSD, we've lost this
capability.  I'd love it if iasl would grow a flag to have this behavior.
You could restrict it to only outputing the macros if the Buffer starts
with a valid resource.

-Nate


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
