From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: problems about ACPI sysfs convert work
Date: Wed, 22 Nov 2006 16:13:41 +0800
Message-ID: <1164183221.5461.41.camel@localhost.localdomain>
References: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com>
	 <1164021493.3721.229.camel@queen.suse.de>
	 <20061121163438.GA16748@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33294 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1161942AbWKVIKW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 03:10:22 -0500
In-Reply-To: <20061121163438.GA16748@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Kay Sievers <kasievers@suse.de>

On Tue, 2006-11-21 at 16:34 +0000, Matthew Garrett wrote:
> (I seem to be missing the original mail here...)
>=20
> On Mon, Nov 20, 2006 at 12:18:13PM +0100, Thomas Renninger wrote:
> > > Hello, lists
> > > I=E2=80=99m doing the ACPI sysfs convert work now. And I have som=
e problems when duplicating some procfs interfaces to sysfs.
> > > Under driver model (this will be available soon), files under /pr=
oc/acpi/xxx(driver)/yyy(device)/ will be duplicated under /sys/device/ =
as they are properties of individual devices.
> > > But I still have some trouble on dealing with the files under /pr=
co/acpi, including =E2=80=9Calarm=E2=80=9D, =E2=80=9Csleep=E2=80=9D, =E2=
=80=9Cwakeup=E2=80=9D, =E2=80=9Cdebug_layer=E2=80=9D, =E2=80=9Cdebug_le=
vel=E2=80=9D, =E2=80=9Cdsdt=E2=80=9D, =E2=80=9Cfadt=E2=80=9D, =E2=80=9C=
event=E2=80=9D and =E2=80=9Cinfo=E2=80=9D.
> > > Following is a proposal as well as some problem and I=E2=80=99m n=
ot quite sure about the places all these attributes should be located a=
t. I wish to get some advice from you, and any comment is welcome=E2=98=
=BA.
> > >=20
> > > 1. Where should =E2=80=9Calarm=E2=80=9D be located? Another probl=
em is whether we should put a duration into this file instead of a futu=
re time.
> > Don't know, never used...
>=20
> This should presumably just be handled by the clock driver rather tha=
n=20
> the ACPI subsystem. There's only a tiny amount of acpi-related code i=
n=20
> the driver, and that's information that we could just export to the=20
> clock instead.
>=20
I prefer to locate "alarm" under /sys/power, together with "wakeup".
Yes, you are right that it does have a lot to do with the clock driver.
But I think this patch series should impact other parts little. You
know, the main purpose of this patch series is just to duplicate the
procfs function in sysfs. So only the functions for sysfs interface wil=
l
be added in the first step. :)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
