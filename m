From: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Subject: RE: fan status not working on D600
Date: Thu, 18 Dec 2003 10:42:57 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0312181036260.17824@pcd403z.vsb.cz>
References: <C386328088ED7F4E9F81AFBABDDF60DA0378CC56@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA0378CC56-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have D600 and I am using i8k modules to control fan without problem.

But if you are using bios A08, then SMM bios turn on fan back, after I
switch it off. With BIOS A05 and A06 work fine.
And on d600 is only fan 0 supported, fan 1 is not present.

Over acpi I have not fan control.

poli


On Thu, 18 Dec 2003, Ow Mun Heng wrote:

> Hi Yu, Liming,
>
> =09I tied passing acpi=3Doff into the kernel last night. Upon boot-up,
> the fan
> was not running. (usually with ACPI=3Don, the fan would turn on as soon a=
s I
> boot up
> RH)
>
> However, the fan did kick in after like 5 min. (most likely since I didn'=
t
> have acpi
> and thus power management did not work and  CPU Freq was at max etc...)
>
> RUnning i8kutils or i8kctl (from the i8k debian package with insmod i8k
> force=3D1)
> I wasn;t able to control the fan either.
>
> So.. Additional Info.. Do you want me to file this into bugzilla as well?=
?
>
> Cheers,
> OW
>
> http://bugme.osdl.org/show_bug.cgi?id=3D1643
>
> > -----Original Message-----
> > From: Ow Mun Heng
> > Sent: Thursday, December 04, 2003 6:11 PM
> > To: Yu, Luming; Herv=E9 Eychenne; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: RE: [ACPI] fan status not working with kernel
> > 2.6.0-test11 for
> > Acer Travelmate 803 LCI
> >
> >
> >
> >
> >
> > > -----Original Message-----
> > > From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > > Sent: Thursday, December 04, 2003 11:47 AM
> > > To: Ow Mun Heng; Herv=E9 Eychenne; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Subject: RE: [ACPI] fan status not working with kernel
> > > 2.6.0-test11 for
> > > Acer Travelmate 803 LCI
> > >
> > >
> > > Let me know, if you have done. --Luming
> >
> >
> > Okay... I've filed the bug report.. I hope len.brown isn't furious..
> > bugzilla sent him like 12 attachments reports :)
> >
> > The bug #/link is
> >
> > http://bugme.osdl.org/show_bug.cgi?id=3D1643
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: SF.net Giveback Program.
> > Does SourceForge.net help you be more productive?  Does it
> > help you create better code?  SHARE THE LOVE, and help us help
> > YOU!  Click Here: http://sourceforge.net/donate/
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
>


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
