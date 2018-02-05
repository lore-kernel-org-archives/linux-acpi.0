From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Mon, 5 Feb 2018 17:24:43 +0000
Message-ID: <ddcf31de6764453e98fb8647514ad8fa@ausx13mpc120.AMER.DELL.COM>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
        <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
 <20180205141447.6e1442ac@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:61424 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752582AbeBERYq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2018 12:24:46 -0500
In-Reply-To: <20180205141447.6e1442ac@endymion>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jdelvare@suse.de, alex.hung@canonical.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, f.fainelli@gmail.com, dmitry.torokhov@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:jdelvare@suse.de]
> Sent: Monday, February 5, 2018 7:15 AM
> To: Alex Hung <alex.hung@canonical.com>
> Cc: rjw@rjwysocki.net; lenb@kernel.org; gregkh@linuxfoundation.org;
> davem@davemloft.net; mika.westerberg@linux.intel.com;
> andriy.shevchenko@linux.intel.com; f.fainelli@gmail.com;
> dmitry.torokhov@gmail.com; kishon@ti.com; karniksayli1995@gmail.com; linu=
x-
> acpi@vger.kernel.org; Limonciello, Mario <Mario_Limonciello@Dell.com>
> Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
>=20
> Hi Alex,
>=20
> On Wed, 31 Jan 2018 00:40:05 -0800, Alex Hung wrote:
> > A number of Dell systems require an OEM _OSI string "Linux-Dell-Video" =
as
> > a BIOS workaround for a system hang bug caused by discrete VGA. The for=
m of
> > the OEM _OSI string is discussed in Documentation/acpi/osi.txt and is
> > defined by each OEM.
>=20
> I admit I don't understand how it is the operating system's job to
> carry the information from the BIOS to the BIOS.

The reason it's done this way is so that Linux kernel can revert this behav=
ior when it's
no longer appropriate without system vendor having to issue a BIOS update t=
o do this.

For example if underlying issue that required this BIOS ASL workaround is f=
ixed in a
newer kernel.

You can read the documentation about this in Documentations/acpi/osi.txt.

>=20
> > Signed-off-by: Alex Hung <alex.hung@canonical.com>
> > ---
> >  drivers/acpi/osi.c | 107
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >
> > diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> > index 76998a5..43e4349 100644
> > --- a/drivers/acpi/osi.c
> > +++ b/drivers/acpi/osi.c
> > @@ -477,6 +477,112 @@ static const struct dmi_system_id
> acpi_osi_dmi_table[] __initconst =3D {
> >  	{}
> >  };
> >
> > +static int __init dmi_oem_osi_add(const struct dmi_system_id *d)
> > +{
> > +	struct acpi_osi_entry *osi;
> > +	const char *str =3D d->driver_data;
> > +	int i;
> > +
> > +	for (i =3D 0; i < OSI_STRING_ENTRIES_MAX; i++) {
> > +		osi =3D &osi_setup_entries[i];
> > +		if (!strcmp(osi->string, str)) {
>=20
> This can only happen if the user passes acpi_osi=3DLinux-Dell-Video or
> acpi_osi=3D!Linux-Dell-Video on the boot command line, right?
>=20
> > +			osi->enable =3D true;
>=20
> Does this not prevent the user from explicitly disabling it with
> acpi_osi=3D!Linux-Dell-Video ?
>=20
> > +			continue;
>=20
> Are you not done at this point? I think you want to break, not
> continue, else you may add a duplicate Linux-Dell-Video entry below.

You might have two different entries that apply to the same system in the f=
uture.

At least the way that Dell is intending to use this is that "Linux-Dell-Vid=
eo" would
only apply to ASL related to video configuration.

If for example there is later an issue with audio on a different platform t=
hat also
needed "Linux-Dell-Video", the ASL to do the audio configuration would be a=
ctivated
by "Linux-Dell-Audio".

>=20
> > +		} else if (osi->string[0] =3D=3D '\0') {
> > +			osi->enable =3D true;
> > +			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dmi_system_id acpi_oem_osi_dmi_table[] __initconst=
 =3D {
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell Latitude 5491",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0818]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell Latitude 5591",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0819]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell Precision 3530",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0820]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell Inspiron 7777 AIO",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0850]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell Inspiron 5477 AIO",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0851]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell G5 5779",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0886]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell G5 5779",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0870]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell G5 5579",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[086F]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{
> > +	.callback =3D dmi_oem_osi_add,
> > +	.ident =3D "Dell G5 5579",
> > +	.matches =3D {
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "Dell System"),
> > +		     DMI_EXACT_MATCH(DMI_OEM_STRING, "1[0885]"),
> > +		},
> > +	.driver_data =3D "Linux-Dell-Video",
> > +	},
> > +	{}
> > +};
>=20
> G5 5779 and G5 5579 appear twice each, are these copy-and-paste errors?

No, there are two different PCBs that can be used in these systems.  They s=
hare
same "Product Name".  You can only differentiate between them via OEM strin=
g.

>=20
> Choosing a sort rule and sticking to it would make it easier to add
> entries later with not risk of duplicates.
>=20
> > +
> >  static __init void acpi_osi_dmi_blacklisted(void)
> >  {
> >  	dmi_check_system(acpi_osi_dmi_table);
> > @@ -496,6 +602,7 @@ int __init early_acpi_osi_init(void)
> >  int __init acpi_osi_init(void)
> >  {
> >  	acpi_install_interface_handler(acpi_osi_handler);
> > +	dmi_check_system(acpi_oem_osi_dmi_table);
> >  	acpi_osi_setup_late();
> >
> >  	return 0;
>=20
>=20
> --
> Jean Delvare
> SUSE L3 Support
