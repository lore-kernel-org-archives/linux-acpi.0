From: Chander Kant <ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org>
Subject: RE: need debugging help
Date: Sun, 13 Jul 2003 17:04:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.0.20030713170300.02dc44f8@linuxcertified.com>
References: <F760B14C9561B941B89469F59BA3A847E97021@orsmsx401.jf.intel.
 com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E97021@orsmsx401.jf.intel.
 com>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Unfortunately I don't have a way of changing the System BIOS. Can you 
please provide a link to the patch you mention below, and any instructions 
on how to apply it.

thanks

At 05:04 PM 13/07/2003 -0700, Grover, Andrew wrote:
>Hi, sorry for the delay.
>
>So do you have the ability to change your systems' BIOS? If so it is an
>easy fix. If not, then there is a Relaced AML patch to workaround this
>issue, but the ideal situation would be to fix the firmware.
>
>Regards -- Andy
>
> > -----Original Message-----
> > From: Chander Kant [mailto:ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org]
> > Sent: Tuesday, July 01, 2003 5:13 PM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Cc: Grover, Andrew; ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org
> > Subject: need debugging help
> >
> >
> >
> > Thanks Andrew. I am moving the discussion to the acpi-devel list:
> >
> > All,
> >
> > I am attaching the output of "iasl -d dsdt" (in zipped format).
> >
> > Please let me know if we can do anything on this system to
> > get rid of the problem mentioned below.
> >
> > Thanks,
> > Chander
> >
> >
> > "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote ..
> > > > When we bring up a recent Linux kernel (2.4.20) with ACPI
> > > > patch on our laptop. We get following error messages
> > > > continously from the kernel:
> > > >
> > > > Jul  2 04:31:16 localhost kernel:     ACPI-1103: *** Error:
> > > > Method execution failed [\_SB_.PCI0.SBRG.EC0_._Q1E] (Node
> > > > c33b1380), AE_AML_REGION_LIMIT
> > > >
> > > > Besides filling up the log files, and making the console
> > > > windows, I think it is also hampering ACPI functionality to
> > > > work, as I do not see and battery file in the /proc/acpi
> > directory.
> > > >
> > > > I have seen other folks in user groups and lists getting
> > > > these errors, but so far I have not seen a good response as
> > > > far as a fix or workaround.
> > >
> > > It's most likely an AML error. This particular error is not
> > uncommon.
> > >
> > > Do you have the ASL for this machine? If not, get iasl from
> > >
> > http://developer.intel.com/technology/iapc/acp> i/downloads.htm and
>feed
> > > your DSDT into it (from /proc/acpi/dsdt). with the -d
> > option. Then, go
> > > take a look at the _Q1E method.
> > >
> > >
> >



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
