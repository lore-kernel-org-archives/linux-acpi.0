From: Len Brown <len.brown@intel.com>
Subject: Re: problems about ACPI sysfs convert work
Date: Wed, 22 Nov 2006 17:12:35 -0500
Message-ID: <200611221712.37199.len.brown@intel.com>
References: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com> <1164021493.3721.229.camel@queen.suse.de> <20061121163438.GA16748@srcf.ucam.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33715 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1755707AbWKVWJ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 17:09:57 -0500
In-Reply-To: <20061121163438.GA16748@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Li, Shaohua" <shaohua.li@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Kay Sievers <kasievers@suse.de>

On Tuesday 21 November 2006 11:34, Matthew Garrett wrote:

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

Matthew, exactly what code in "the clock driver" to you refer to that
should be involved here?

Re: duration vs. absolute time.
Currently use use absolute time, and that capability needs to stay.

I requested also a sleep duration capability.
I'd like to use it to make the suspend/resume stress test suite a littl=
e better,
but others might like it for "real" use as well.
Either a different sysfs file, or a special syntax like preceeding the =
time
with a '+' to make it a duration?

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
