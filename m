From: Thomas Renninger <trenn@suse.de>
Subject: Re: + acpi-use-acpi_debug_print-instead-of-printk.patch added to
	-mm tree
Date: Sun, 17 Feb 2008 00:33:56 +0100
Message-ID: <1203204836.4134.18.camel@linux-2bdv.site>
References: <200802152128.m1FLSMGi024897@imap1.linux-foundation.org>
	 <200802151712.36300.lenb@kernel.org>  <47B61E90.6070005@redhat.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:39424 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbYBPXd7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Feb 2008 18:33:59 -0500
In-Reply-To: <47B61E90.6070005@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Glauber Costa <gcosta@redhat.com>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, mm-commits@vger.kernel.org


On Fri, 2008-02-15 at 21:21 -0200, Glauber Costa wrote:
> Len Brown wrote:
> > I.e. this printk will be present in a production shipping distro ke=
rnel
> > even if you move to to ACPI_DEBUG_PRINT from printk.
> Yes, but you can still disable it. And if you do, all the messages wi=
ll=20
> vanish, but this will stay.
>=20
> > The only variable  is the default verbosity level.
> >=20
> > Thomas, what verbosity level do you use?
> in this patch, I used the same verbosity level as the EJECT request. =
So
> if it is not okay for SuSe, I suggest changing all the others too.
That should be ok, thanks for the heads up.
It is 0x7:

ACPI_LV_ERROR                   0x00000001 [*]
ACPI_LV_WARN                    0x00000002 [*]
ACPI_LV_INIT                    0x00000004 [*]
ACPI_LV_DEBUG_OBJECT            0x00000008 [ ]
ACPI_LV_INFO                    0x00000010 [ ]
ACPI_LV_INIT_NAMES              0x00000020 [ ]

All above INIT (already DEBUG_OBJECT) produces unwanted messages and is
nothing for default.
I remember that default for mainline included DEBUG_OBJECT a while ago,
but if I haven't overseen something that should have changed:

=EF=BB=BFinclude/acpi/acoutput.h:#define ACPI_DEBUG_DEFAULT          (A=
CPI_LV_INIT | ACPI_LV_WARN | ACPI_LV_ERROR)
drivers/acpi/utilities/utglobal.c:u32 acpi_dbg_level =3D ACPI_DEBUG_DEF=
AULT;

and everything is fine.

Thanks,

   Thomas
>=20
> > thanks,
> > -Len
> >=20
> > On Friday 15 February 2008 16:28, akpm@linux-foundation.org wrote:
> >> The patch titled
> >>      acpi: use ACPI_DEBUG_PRINT instead of printk
> >> has been added to the -mm tree.  Its filename is
> >>      acpi-use-acpi_debug_print-instead-of-printk.patch
> >>
> >> Before you just go and hit "reply", please:
> >>    a) Consider who else should be cc'ed
> >>    b) Prefer to cc a suitable mailing list as well
> >>    c) Ideally: find the original patch on the mailing list and do =
a
> >>       reply-to-all to that, adding suitable additional cc's
> >>
> >> *** Remember to use Documentation/SubmitChecklist when testing you=
r code ***
> >>
> >> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.tx=
t to find
> >> out what to do about this
> >>
> >> The current -mm tree may be found at http://userweb.kernel.org/~ak=
pm/mmotm/
> >>
> >> ------------------------------------------------------
> >> Subject: acpi: use ACPI_DEBUG_PRINT instead of printk
> >> From: Glauber Costa <gcosta@redhat.com>
> >>
> >> For consistency, use ACPI_DEBUG_PRINT instead of printk in
> >> acpi_processor_hotplug_notify() for BUS_CHECK and DEVICE_CHECK eve=
nts
> >>
> >> Signed-off-by: Glauber Costa <gcosta@redhat.com>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>
> >>  drivers/acpi/processor_core.c |    5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff -puN drivers/acpi/processor_core.c~acpi-use-acpi_debug_print-=
instead-of-printk drivers/acpi/processor_core.c
> >> --- a/drivers/acpi/processor_core.c~acpi-use-acpi_debug_print-inst=
ead-of-printk
> >> +++ a/drivers/acpi/processor_core.c
> >> @@ -890,9 +890,10 @@ acpi_processor_hotplug_notify(acpi_handl
> >>  	switch (event) {
> >>  	case ACPI_NOTIFY_BUS_CHECK:
> >>  	case ACPI_NOTIFY_DEVICE_CHECK:
> >> -		printk("Processor driver received %s event\n",
> >> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >> +		"Processor driver received %s event\n",
> >>  		       (event =3D=3D ACPI_NOTIFY_BUS_CHECK) ?
> >> -		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
> >> +		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK"));
> >> =20
> >>  		if (!is_processor_present(handle))
> >>  			break;
> >> _
> >>
> >> Patches currently in -mm which might be from gcosta@redhat.com are
> >>
> >> remove-is_processor_present-prototype.patch
> >> acpi-use-acpi_debug_print-instead-of-printk.patch
> >> git-kvm.patch
> >>
>=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
