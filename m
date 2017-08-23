From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: RE: [PATCH] ACPI, APEI, EINJ: Subtract any matching Register Region
 from Trigger resources
Date: Wed, 23 Aug 2017 16:37:43 +0000
Message-ID: <BN6PR1201MB013106200C118FC6336017C8F8850@BN6PR1201MB0131.namprd12.prod.outlook.com>
References: <1502387883-16667-1-git-send-email-Yazen.Ghannam@amd.com>
 <BN6PR1201MB013138E0E32481E623C35715F8840@BN6PR1201MB0131.namprd12.prod.outlook.com>
 <20170822160305.o4ceuqjnuy4drgxb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170822160305.o4ceuqjnuy4drgxb@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Luck, Tony [mailto:tony.luck@intel.com]
> Sent: Tuesday, August 22, 2017 12:03 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> rjw@rjwysocki.net; lenb@kernel.org; linux-edac@vger.kernel.org; Borislav
> Petkov <bp@suse.de>
> Subject: Re: [PATCH] ACPI, APEI, EINJ: Subtract any matching Register Reg=
ion
> from Trigger resources
>=20
> On Tue, Aug 22, 2017 at 02:04:27PM +0000, Ghannam, Yazen wrote:
> > > *einj_get_trigger_parameter_region(
> > >  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
> > >  	for (i =3D 0; i < trigger_tab->entry_count; i++) {
> > >  		if (entry->action =3D=3D ACPI_EINJ_TRIGGER_ERROR &&
> > > -		entry->instruction =3D=3D ACPI_EINJ_WRITE_REGISTER_VALUE &&
> > >  		entry->register_region.space_id =3D=3D
> > >  			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
> > >  		(entry->register_region.address & param2) =3D=3D (param1 &
> > > param2))
>=20
> Maybe you should add the other instruction types that make sense here
> (ACPI_EINJ_READ_REGISTER, ACPI_EINJ_READ_REGISTER_VALUE and
> ACPI_EINJ_WRITE_REGISTER) as a sanity check against the BIOS giving you a=
n
> action in the trigger table that doesn't involve a memory access?
>=20

Yes, in that case we can do:
entry->instruction <=3D ACPI_EINJ_WRITE_REGISTER_VALUE

That would cover all the memory access instructions and protect against inv=
alid
instructions.

How does that sound?

Thanks,
Yazen
