From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Intel SE7500WV2 not working with ACPI (fwd)
Date: Fri, 2 Jan 2004 13:09:04 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040102130742.G9534@root.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

I can't figure this one out.  I think the issue is that various methods
are defined under device "EC0" (note 3 chars) but when ACPI-CA attempts to
call _REG, some internal function expands the name to "EC0_" (note 4
chars), which doesn't exist.

Ideas?

Thanks,
Nate

---------- Forwarded message ----------
Date: Tue, 25 Nov 2003 15:04:26 -0800
From: Brooks Davis <brooks-JGfshJpz5UybPZpvUQj5UqxOck334EZe@public.gmane.org>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Brooks Davis <brooks-JGfshJpz5UybPZpvUQj5UqxOck334EZe@public.gmane.org>, current@freebsd.org
Subject: Re: Intel SE7500WV2 not working with ACPI

On Tue, Nov 25, 2003 at 12:12:16PM -0800, Nate Lawson wrote:
> > acpi0: <INTEL  SWV20   > on motherboard
> >     ACPI-1287: *** Error: Method execution failed [\\_SB_.PCI0.SBRG.EC0_._REG] (Node 0xc29b4660), AE_NOT_EXIST
> > acpi0: Could not initialise SystemIO handler: AE_NOT_EXIST
> > device_probe_and_attach: acpi0 attach returned 6
>
> This is the source of the problems.  When acpi0 fails to attach,
> everything else is done through the legacy PCI code.  The question is, why
> is it failing?  The above-mentioned EC method could indicate the problem
> is in walking the namespace but we'll have to look at the ASL to be sure.
>
> Please send a url to the output of:
>      acpidump -t -d > brooks-Intel.asl

http://people.freebsd.org/~brooks/debug/brooks-Intel.asl

> Also, build with options ACPI_DEBUG and set these in your loader.conf:
>
> debug.acpi.layer="ACPI_ALL_COMPONENTS"
> debug.acpi.level="ACPI_LV_OPREGION"

There's a new dmesg with this done at:

http://people.freebsd.org/~brooks/debug/dmesg-brooks-Intel

Thanks,
Brooks


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
