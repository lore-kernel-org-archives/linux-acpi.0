From: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Subject: Re: S3 resume only reboots
Date: Thu, 8 Jul 2004 13:39:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200407081339.40357.jak97@doc.ic.ac.uk>
References: <20040707095716.26188.qmail@web25002.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040707095716.26188.qmail-o3UUcWX0NMrGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Will Woods <will_woods2-/E1597aS9LT10XsdtD+oqA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Will

Please could you post your machine configuration. I have the same problem, and 
it would be good to see if we have any common hardware. You can find out more 
about my machine at 

	http://www.doc.ic.ac.uk/~jak97/dsdt/

Items of interest is the output of

	/proc/config.gz (if it's there)
	/proc/cpuinfo
	/proc/interrupts
	dmesg
	lspci
	lspci -v

Cheers

John

On Wednesday 07 July 2004 10:57, Will Woods wrote:
> Ok, I have compiled the 2.6.7 kernel with latest acpi
> patch (acpi-20040326-2.6.7.diff), and I still have the
> same problem (and yes, I have checked that I'm running
> the new kernel :)
>
> Any ideas would be much appreciated.
>
> Will
>
>
> --- Will Woods <will_woods2-/E1597aS9LT10XsdtD+oqA@public.gmane.org> wrote: >
>
> > Hi,
> >
> > I think I can get my machine to suspend to ram with
> > 'echo 3 > /proc/aci/sleep', but a subsequent press
> > of
> > the power button just starts a fresh boot. The only
> > other button I have is the reset, which does
> > nothing,
> > and the keyboard is also ignored. I can't figure out
> > if the machine is just powering off (in about 1
> > second), or if I'm really getting the S3 mode. If I
> > am, is there anything I can configure to ensure the
> > power button does not do a reboot? S3 works fine
> > under
> > windows XP, so I assume that the problem is not with
> > the hardware.
> >
> > I'm running Mandrake 10 with kernel 2.6.3-7mdk.
> >
> >
> > Will
>
> ___________________________________________________________ALL-NEW
>
> > Yahoo! Messenger - sooooo many all-new ways to
> > express yourself http://uk.messenger.yahoo.com
>
> -------------------------------------------------------
>
> > This SF.Net email sponsored by Black Hat Briefings &
> > Training.
> > Attend Black Hat Briefings & Training, Las Vegas
> > July 24-29 -
> > digital self defense, top technical experts, no
> > vendor pitches,
> > unmatched networking opportunities. Visit
> > www.blackhat.com
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
>
>
>
>
> ___________________________________________________________ALL-NEW Yahoo!
> Messenger - sooooo many all-new ways to express yourself
> http://uk.messenger.yahoo.com
>
>
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
> digital self defense, top technical experts, no vendor pitches,
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
