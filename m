From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Tue, 6 Feb 2018 00:45:31 +0000
Message-ID: <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
 <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
 <20180205141447.6e1442ac@endymion>
 <1517840100.22495.25.camel@linux.intel.com>
 <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
 <20180205224531.GA46524@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:21487 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750903AbeBFApd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2018 19:45:33 -0500
In-Reply-To: <20180205224531.GA46524@dtor-ws>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: andriy.shevchenko@linux.intel.com, jdelvare@suse.de, alex.hung@canonical.com, rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, f.fainelli@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Monday, February 5, 2018 4:46 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: andriy.shevchenko@linux.intel.com; jdelvare@suse.de;
> alex.hung@canonical.com; rjw@rjwysocki.net; lenb@kernel.org;
> gregkh@linuxfoundation.org; davem@davemloft.net;
> mika.westerberg@linux.intel.com; f.fainelli@gmail.com; kishon@ti.com;
> karniksayli1995@gmail.com; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
>=20
> On Mon, Feb 05, 2018 at 05:36:18PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > -----Original Message-----
> > > From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> > > Sent: Monday, February 5, 2018 8:15 AM
> > > To: Jean Delvare <jdelvare@suse.de>; Alex Hung <alex.hung@canonical.c=
om>
> > > Cc: rjw@rjwysocki.net; lenb@kernel.org; gregkh@linuxfoundation.org;
> > > davem@davemloft.net; mika.westerberg@linux.intel.com;
> f.fainelli@gmail.com;
> > > dmitry.torokhov@gmail.com; kishon@ti.com; karniksayli1995@gmail.com;
> linux-
> > > acpi@vger.kernel.org; Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
> > >
> > > On Mon, 2018-02-05 at 14:14 +0100, Jean Delvare wrote:
> > >
> > > > On Wed, 31 Jan 2018 00:40:05 -0800, Alex Hung wrote:
> > > > > A number of Dell systems require an OEM _OSI string "Linux-Dell-
> > > > > Video" as
> > > > > a BIOS workaround for a system hang bug caused by discrete VGA. T=
he
> > > > > form of
> > > > > the OEM _OSI string is discussed in Documentation/acpi/osi.txt an=
d
> > > > > is
> > > > > defined by each OEM.
> > > >
> > > > I admit I don't understand how it is the operating system's job to
> > > > carry the information from the BIOS to the BIOS.
> > >
> > > > > +	for (i =3D 0; i < OSI_STRING_ENTRIES_MAX; i++) {
> > > > > +		osi =3D &osi_setup_entries[i];
> > > > > +		if (!strcmp(osi->string, str)) {
> > > >
> > > > This can only happen if the user passes acpi_osi=3DLinux-Dell-Video=
 or
> > > > acpi_osi=3D!Linux-Dell-Video on the boot command line, right?
> > > >
> > > > > +			osi->enable =3D true;
> > > >
> > > > Does this not prevent the user from explicitly disabling it with
> > > > acpi_osi=3D!Linux-Dell-Video ?
> > >
> > > Playing with OSI string is a bad idea. I wouldn't do anything while
> > > Rafael, or even Len can confirm that is the right thing to do.
> > >
> > > For me, AFAIK we need to be bug-to-bug compatible with Windows (at le=
ast
> > > on ACPICA side), so, what Windows exactly does on such laptops?
> > >
> >
> > The issue that's being worked around isn't an ACPICA interpreter issue,=
 but it's
> > a graphics device configuration issue.
> >
> > Windows expects to use RTD3 on the NVIDIA GPU but Linux drivers
> > don't.  It leads to system hangs on the Linux side.
>=20
> Can we adjust Linux drivers to do the right thing? Or is it regarding
> the binary NVIDIA blob?
>=20

Neither Nouveau nor the NVIDIA blob have support for RTD3.

Last I heard it's waiting on NVIDIA releasing something Nouveau
needs.  So.. Eventually?  For now it's better to not hang though.

That's part of why we wanted to enable this via a transient OSI string,
to let this be removed by Linux whenever the driver does grow support.

