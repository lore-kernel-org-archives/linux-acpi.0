From: Alexander Malysh <a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] Re: [BUG] acpi_hw_[enable|disable]_non_wakeup_gpe_block
Date: Sun, 15 Feb 2004 22:00:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402152200.08010.a.malysh@centrium.de>
References: <200402142317.41033.a.malysh@centrium.de> <200402151647.21826.a.malysh@centrium.de> <20040215200724.GN13262@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040215200724.GN13262-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 15 February 2004 21:07, you wrote:
> On Sun, Feb 15, 2004 at 04:47:19PM +0100, Alexander Malysh wrote:
> > Hi again,
> >
> > after some more testing, I have found a cause for this.
> > We disable non wakeup gpes (and store those values) with interrupts
> > disabled, but enable those with interrupts enabled which were already
> > overwritten while handling of wakeup interrupt[1]. So we must restore non
> > wakeup gpes as long interrupts are disabled. Attached patch should fix
> > it.
> >
> >
> > --- linux-2.6.2-linus/drivers/acpi/hardware/hwsleep.c~orig	2004-02-15
> > 16:31:50.928455040 +0100 +++
> > linux-2.6.2-linus/drivers/acpi/hardware/hwsleep.c	2004-02-15
> > 16:35:30.030146520 +0100 @@ -342,6 +342,12 @@
> >
> >  	} while (!in_value);
> >
> > +	/* Enable non_wakeup_gpes as long interrupts are disabled */
> > +	status = acpi_hw_enable_non_wakeup_gpes ();
> > +	if (ACPI_FAILURE (status)) {
> > +		return_ACPI_STATUS (status);
> > +	}
> > +
> >  	return_ACPI_STATUS (AE_OK);
>
> First, this path is *never reached* for S3 and S4, so you break somehow S3
> and S4 in fact...

hmm, where do we jump after wakeup from S3/S4 ?

>
> Second, the path for which you remove the enable gpes is supposed to be
> run with interrupt *dissabled*.  If that is not the case, then it is the
> real bug in fact.

as you can see from log (or in drivers/acpi/sleep/main.c) 
acpi_leave_sleep_state called with interrupts enabled.
and you are right: acpi_leave_sleep_state _must_ be called with interrupts 
disabled, so no wonder why sleep/resume fail on many laptops :(



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
