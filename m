From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: ACPI trouble (AC module, etc.) with Toshiba 1115-S103
Date: Wed, 11 Dec 2002 08:41:41 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <00ce01c2a112$a79ddfe0$3746028e@bio.dfo.ca>
References: <20021211065826.5869.qmail@web14503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: "NoZizzing OrDripping" <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
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

Not if it doesn't conform to the ACPI spec. I wouldn't have a clue if this
does - but MS is well known for going their own way.  If that was the case, then
the goal would be to get your PC vendor to get a correct DSDT - we shouldn't be
trying to make ACPI work with every possible broken BIOS.



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
