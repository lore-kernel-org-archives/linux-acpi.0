From: Bernhard Kaindl <bernhard.kaindl-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Relaxed AML parsing
Date: Fri, 28 Feb 2003 23:17:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0302282248540.1622@hase.a11.local>
References: <Pine.LNX.4.53.0302280059170.1511@hase.a11.local>
 <20030228133015.GD13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030228133015.GD13404-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Rick Richardson <rickr-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello Bruno!

    thanks for your help:

On Fri, 28 Feb 2003, Ducrot Bruno wrote:
> On Fri, Feb 28, 2003 at 02:24:04AM +0100, Bernhard Kaindl wrote:
> >
> > http://home.mn.rr.com/richardsons/toshiba-1115-s103/relaxed-aml.patch
> >
> > I think it's only nuts and bolts if the Linux AML parser tolerates
> > the same errors which the ASL compiler tolerates.
> >
> > I'm new to ACPI, so I would like to ask you if you agree with the above
> > and if you think that the relaxed AML parsing should be be included and
> > enabled in the acpi patches.
>
> One of the main problem with Rick's patch is that it is too tolerate.  The
> same code is shared with other checks so that it may be now possible
> to corrupt some buffers especially in case of bug in ACPI-CA.

Is the function checking phyical or virtual adresses?

I guess it should be about checking physical addresses because the
only reason for this should be physical address I/O.

But if this is physical address I/O and the access goes to the right
address in the end, and it works he same way in Windows, I don't see
any risk to access a data buffer, because there just the physical I/O
addresses should live, and not normal RAM.

Maybe the check needs to be really strict for ACPI-CA, but I think for
the cases that users experiance the AE_AML_REGION_LIMIT check problems,
there the rounded-up checking should be enough and safe, because the
same DSDT(accessing the AC status) just works with Windows.

Again, please excuse if I'm overlooking something, I'm just searching
for a solution which works with the shipped and working DSDT tables.

Thanks,
Bernd


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
