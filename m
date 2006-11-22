From: Thomas Renninger <trenn@suse.de>
Subject: Re: problems about ACPI sysfs convert work
Date: Wed, 22 Nov 2006 11:49:02 +0100
Message-ID: <1164192542.3721.320.camel@queen.suse.de>
References: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com>
	 <1164021493.3721.229.camel@queen.suse.de>
	 <1164158892.3551.3.camel@sli10-conroe.sh.intel.com>
	 <1164182027.5461.22.camel@localhost.localdomain>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:63912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162031AbWKVKtC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 05:49:02 -0500
In-Reply-To: <1164182027.5461.22.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Kay Sievers <kasievers@suse.de>

On Wed, 2006-11-22 at 15:53 +0800, Zhang Rui wrote:
> On Wed, 2006-11-22 at 09:28 +0800, Shaohua Li wrote:
> > On Mon, 2006-11-20 at 12:18 +0100, Thomas Renninger wrote:
> > > On Mon, 2006-11-20 at 18:10 +0800, Zhang, Rui wrote:
> > > > Hello, lists
> > > > I=E2=80=99m doing the ACPI sysfs convert work now. And I have s=
ome problems when duplicating some procfs interfaces to sysfs.
> > > > Under driver model (this will be available soon), files under /=
proc/acpi/xxx(driver)/yyy(device)/ will be duplicated under /sys/device=
/ as they are properties of individual devices.
> > > > But I still have some trouble on dealing with the files under /=
prco/acpi, including =E2=80=9Calarm=E2=80=9D, =E2=80=9Csleep=E2=80=9D, =
=E2=80=9Cwakeup=E2=80=9D, =E2=80=9Cdebug_layer=E2=80=9D, =E2=80=9Cdebug=
_level=E2=80=9D, =E2=80=9Cdsdt=E2=80=9D, =E2=80=9Cfadt=E2=80=9D, =E2=80=
=9Cevent=E2=80=9D and =E2=80=9Cinfo=E2=80=9D.
> > > > Following is a proposal as well as some problem and I=E2=80=99m=
 not quite sure about the places all these attributes should be located=
 at. I wish to get some advice from you, and any comment is welcome=E2=98=
=BA.
> > > >=20
> > > > 1. Where should =E2=80=9Calarm=E2=80=9D be located? Another pro=
blem is whether we should put a duration into this file instead of a fu=
ture time.
> > > Don't know, never used...
> > > > 2. =E2=80=9Csleep=E2=80=9D is already marked as deprecated beca=
use /sys/power/state has the same function. I won=E2=80=99t do the repe=
ated work again.
> > > Yep.
> > > > 3. =E2=80=9Cwakeup=E2=80=9D should not exist, but be an attribu=
te of individual devices kobjects.
> > > Maybe the devices can be linked
> > > like /sys/.../wakeup/${links_to_wakeup_devices}
> > > So that userspace does not need to search over the whole device t=
ree to
> > > find them?
> Sounds great. I'll have a try.
> > Sounds like a good idea. But this should be done in driver core. Ot=
her
> > devices like pci might support wakeup too. device declaims to suppo=
rt
> > wakeup, and driver core create a link to /sys/.../wakeup/xxx. I'd
> > suggest don't do this in acpi part.
> >=20
> Yes. That makes sense. But I don't want too many files to be involved=
,
> especially at the beginning. :). This should be done in another patch=
 in
> the future if everything goes well.

Yep, enabling the core ACPI sysfs stuff first sounds like a good idea?
(I am especially looking for ACPI module autoloading..., probing blindl=
y
all ACPI modules on all x86 machines is really ugly atm...) Getting
every detail duplicated or not from /proc/acpi can later be integrated
as needed. Small on top patches later are easier to review and less
error prone, once the basic stuff runs fine?

  Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
