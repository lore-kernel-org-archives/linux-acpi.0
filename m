From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: broken bm_sts on 82801CA?
Date: Wed, 8 Oct 2003 10:40:21 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031008103531.B10689@root.org>
References: <20031006233406.N4792@root.org> <20031007085536.GB11391@poupinou.org>
 <20031007110948.V6708@root.org> <20031008123103.GG11391@poupinou.org>
 <20031008095321.B10515@root.org> <20031008172800.GI11391@poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031008172800.GI11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 8 Oct 2003, Ducrot Bruno wrote:
> On Wed, Oct 08, 2003 at 09:55:35AM -0700, Nate Lawson wrote:
> > On Wed, 8 Oct 2003, Ducrot Bruno wrote:
> > > That more an hardware design issue due to how hotplug work in usb busses
> > > in general, and it may need to be workaround, so if anybody haven't yet worked on
> > > C-states on FreeBSD..  Please note also that Linux do not workaround that
> > > btw.
> >
> > I have implemented C-states in freebsd, that's how I ran into this
> > problem.  I'll be committing the code once it's cleaned up a little.
> >
> > Since Linux always demotes to "don't enter a Cx state" if bm_sts indicates
> > activity, are you saying that if you have a USB bus configured in Linux,
> > you don't even use C1 (HLT)?
>
> What?  If so, there is a bug somewhere since we should look at bm status only at
> C2 (only if we have to go to C3) or C3 state.
> Sound like you are right, btw.  I have to look a little deeper.  Thanks for pointing
> this.

This is from 2.5.74.  If C3 is supported by the platform, unconditionally
set flags.bm_check:

		else {
			pr->power.states[ACPI_STATE_C3].valid = 1;
			pr->power.states[ACPI_STATE_C3].latency_ticks =
				US_TO_PM_TIMER_TICKS(acpi_fadt.plvl3_lat);
			pr->flags.bm_check = 1;
		}

In acpi_processor_idle(), if bm_check, read the bm_sts register and if it
is non-zero, set next_state to be the demotion state but don't sleep this
quantum.  Instead, enable IRQs and stay active:

		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
			local_irq_enable();
			next_state = cx->demotion.state;
			goto end;
		}

However, since this code is run every time acpi_processor_idle() is
called, it will never enter even C2 if you have a bm_sts bit that is
always 1.

-Nate


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
