From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI trouble (AC module, etc.) with Toshiba 1115-S103
Date: Fri, 13 Dec 2002 23:22:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213222201.GU4327@poup.poupinou.org>
References: <20021210092357.GA29390@poup.poupinou.org> <20021211065826.5869.qmail@web14503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021211065826.5869.qmail-ugbtuMWqwv6A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 10, 2002 at 10:58:26PM -0800, NoZizzing OrDripping wrote:
> --- Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:


...

> 
> OK, I went thru the process of creating a modified
> ASL (diffs from the original attached) for this
> laptop.
> Basically, I cleaned up the original so that the
> errors
> from "iasl" went away.
> 
> I now have a working AC module.
> 
> This is a stopgap measure though, correct?  The goal
> should be for the Linux kernel to support the existing
> AML in flash (the AML apparently comes from Microsoft)

No, it come from your BIOS.  Microsoft make only a
interpreter for it, as for ACPI-CA.

> on these laptops.  The BIOS on these machines is about
> as fresh as it gets (Nov, 2002).  It seems to me that
> the Intel ASL compiler and interpreter needs to be
> changed/relaxed to accomodate what has become a
> defacto
> (de-gates-o) standard here.
> 
> As a practical matter, I can't imagine non-programmer
> types having to modify their ASL code to make Linux
> work on their laptops, and I can't imagine that Ducrot
> wants to be the single, worldwide point, for modified

No, I don't want to.  FreeBSD acpi team is good also for
this stuff as well.

> Would the ACPI developers be receptive if I made the
> changes necessary to allow the kernel ACPI code to
> accept the existing AML in my laptop as-is?

It's up to Intel ACPI guy to decide, but if I were them,
I will _not_ allow to do the same kind of bug as MS.

Imagine if they have to program as a MS developper...

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
