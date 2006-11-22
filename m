From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: problems about ACPI sysfs convert work
Date: Wed, 22 Nov 2006 09:28:12 +0800
Message-ID: <1164158892.3551.3.camel@sli10-conroe.sh.intel.com>
References: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com>
	 <1164021493.3721.229.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58753 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1161503AbWKVB2m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 20:28:42 -0500
In-Reply-To: <1164021493.3721.229.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Kay Sievers <kasievers@suse.de>

On Mon, 2006-11-20 at 12:18 +0100, Thomas Renninger wrote:
> On Mon, 2006-11-20 at 18:10 +0800, Zhang, Rui wrote:
> > Hello, lists
> > I=E2=80=99m doing the ACPI sysfs convert work now. And I have some =
problems when duplicating some procfs interfaces to sysfs.
> > Under driver model (this will be available soon), files under /proc=
/acpi/xxx(driver)/yyy(device)/ will be duplicated under /sys/device/ as=
 they are properties of individual devices.
> > But I still have some trouble on dealing with the files under /prco=
/acpi, including =E2=80=9Calarm=E2=80=9D, =E2=80=9Csleep=E2=80=9D, =E2=80=
=9Cwakeup=E2=80=9D, =E2=80=9Cdebug_layer=E2=80=9D, =E2=80=9Cdebug_level=
=E2=80=9D, =E2=80=9Cdsdt=E2=80=9D, =E2=80=9Cfadt=E2=80=9D, =E2=80=9Ceve=
nt=E2=80=9D and =E2=80=9Cinfo=E2=80=9D.
> > Following is a proposal as well as some problem and I=E2=80=99m not=
 quite sure about the places all these attributes should be located at.=
 I wish to get some advice from you, and any comment is welcome=E2=98=BA=
=2E
> >=20
> > 1. Where should =E2=80=9Calarm=E2=80=9D be located? Another problem=
 is whether we should put a duration into this file instead of a future=
 time.
> Don't know, never used...
> > 2. =E2=80=9Csleep=E2=80=9D is already marked as deprecated because =
/sys/power/state has the same function. I won=E2=80=99t do the repeated=
 work again.
> Yep.
> > 3. =E2=80=9Cwakeup=E2=80=9D should not exist, but be an attribute o=
f individual devices kobjects.
> Maybe the devices can be linked
> like /sys/.../wakeup/${links_to_wakeup_devices}
> So that userspace does not need to search over the whole device tree =
to
> find them?
Sounds like a good idea. But this should be done in driver core. Other
devices like pci might support wakeup too. device declaims to support
wakeup, and driver core create a link to /sys/.../wakeup/xxx. I'd
suggest don't do this in acpi part.

Thanks,
Shaohua
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
