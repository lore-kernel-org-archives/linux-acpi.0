From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Devel] Re: [RESEND] [PATCH 2/3] Introduce
	acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Thu, 13 Nov 2008 10:21:00 +0800
Message-ID: <1226542860.15014.187.camel@rzhang-dt>
References: <200810192350.57993.trenn@suse.de>
	 <20081111005856.GA10535@srcf.ucam.org>  <200811121758.39105.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44433 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbYKMCUg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 21:20:36 -0500
In-Reply-To: <200811121758.39105.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "me@markdoughty.co.uk" <me@markdoughty.co.uk>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "devel@acpica.org" <devel@acpica.org>

On Thu, 2008-11-13 at 07:58 +0800, Thomas Renninger wrote:
> On Monday 10 November 2008 06:58:56 pm Matthew Garrett wrote:
> > I've now had confirmation from multiple sources that Vista still us=
es
> > the 32-bit addresses for the GPE blocks.
> Are you sure that Windows Server implementations also use 32-bit addr=
esses?
> Are you sure that upcoming Windows implementations will always use 32=
-bit=20
> addresses?
> Do all X86 machines support Windows or could there be machines, espec=
ially=20
> servers which only support Mac OS, Solaris/Linux or other OSes which =
stick to=20
> the spec which you break with this change?
> > We're actually seeing the same=20
> > bug on some currently shipping machines
> Which ones?
> > , so again I'm going to suggest=20
> > that the blacklist model isn't going to scale and we should just be=
have
> > like Windows. How about this patch instead? It does some sanity
> > checking, so I doubt that there's any way it could break a legitima=
te
> > system. I've left IA64 as-is because it seems more likely that ther=
e'd
> > be a requirement for 64-bit setups there.
>=20
> If at all, this should not be added for .28, but for .29 and stay in=20
> linux-next for a while.
> I wonder why all (hmm, hard to say, at least a lot) recent machines h=
ave valid=20
> 64 bit addresses.
> I also disagree with violating the spec unconditionally, breaking mac=
hines=20
> which would stick to it. It's likely that machines do not get a lates=
t=20
> mainline kernel tests. Once this change is in distributions and machi=
nes do=20
> break, people are busted. There should at least be a boot param to sw=
itch=20
> back.
>=20
> We might come away with it. But I have the strong feeling that there =
are=20
> machines running better using 32-bit and machines running better with=
 64-bit=20
> addresses used.
here is an example,
=EF=BB=BFI have a test box which suspends well, but always reboots inst=
ead of
resuming when pressing the power button.
I found that there are two FACS tables on this platform,
XSDT-->FADT1-->Xfacs------>FACS1
	|----->facs-----|
			|->FACS2
RSDT-->FADT2-->facs-----|
Linux uses XSDT on this platform and sets the waking vector in FACS1
when suspending. But it seems that the BIOS only cares for the waking
vector in FACS2, thus it reboots when resuming because the waking vecto=
r
is not set at all.
My original proposal is to install both FADT1.Xfacs and FADT1.facs in t=
o
the global table list and set the waking vectors on both of them.
now it seems that switching back to RSDT if multiple valid FACS tables
exists is also a solution for this issue.

anyway, the boot option is needed, which is much more flexible and make
it easier to verify/workaround such kind of issues.

thanks,
rui
>=20
>        Thomas
>=20
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> >
> > ---
> >
> > Are there even any ACPI platforms where a system io address can be
> > greater than 32 bits? It's limited to 16 bits on x86, so I *really*
> > don't think this is going to break anything. The FADTs I've checked=
 from
> > Thinkpads all seem to have valid 32-bit addresses even using the on=
e
> > obtained from the XSDT.
> >
> > diff --git a/drivers/acpi/events/evgpeblk.c
> > b/drivers/acpi/events/evgpeblk.c index 73c058e..eed35d7 100644
> > --- a/drivers/acpi/events/evgpeblk.c
> > +++ b/drivers/acpi/events/evgpeblk.c
> > @@ -1107,6 +1107,32 @@ acpi_status acpi_ev_gpe_initialize(void)
> >  	 */
> >
> >  	/*
> > +	 * The ACPI specification says that we should use the 64-bit
> > +	 * address offset for the GPE blocks if it exists. However,
> > +	 * Windows uses the legacy address. Various vendors have left
> > +	 * incorrect values in the 64-bit field, which then causes
> > +	 * problems later. Since the vast majority of machines have
> > +	 * never been tested with an OS that uses the 64-bit value by
> > +	 * default, we should behave like Windows and ignore the spec
> > +	 * by only using the 64-bit address if it contains something
> > +	 * that can't be represented in the legacy field. Since system
> > +	 * io space is only 16 bits on x86, this should be entirely
> > +	 * safe.
> > +	 */
> > +
> > +#ifdef CONFIG_X86
> > +	if (acpi_gbl_FADT.gpe0_block &&
> > +	    acpi_gbl_FADT.xgpe0_block.space_id =3D=3D ACPI_ADR_SPACE_SYST=
EM_IO)
> > +		acpi_gbl_FADT.xgpe0_block.address =3D
> > +			(u64)acpi_gbl_FADT.gpe0_block;
> > +
> > +	if (acpi_gbl_FADT.gpe1_block &&
> > +	    acpi_gbl_FADT.xgpe1_block.space_id =3D=3D ACPI_ADR_SPACE_SYST=
EM_IO)
> > +		acpi_gbl_FADT.xgpe1_block.address =3D
> > +			(u64)acpi_gbl_FADT.gpe1_block;
> > +#endif
> > +
> > +	/*
> >  	 * Determine the maximum GPE number for this machine.
> >  	 *
> >  	 * Note: both GPE0 and GPE1 are optional, and either can exist wi=
thout
>=20
>=20
> _______________________________________________
> Devel mailing list
> Devel@lists.acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
