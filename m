From: Thomas Renninger <trenn@suse.de>
Subject: Re: problems about ACPI sysfs convert work
Date: Mon, 20 Nov 2006 12:18:13 +0100
Message-ID: <1164021493.3721.229.camel@queen.suse.de>
References: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:6872 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1756725AbWKTLSO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Nov 2006 06:18:14 -0500
In-Reply-To: <58A36151585E4047913F40517D307BAE01719E@pdsmsx404.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Kay Sievers <kasievers@suse.de>

On Mon, 2006-11-20 at 18:10 +0800, Zhang, Rui wrote:
> Hello, lists
> I=E2=80=99m doing the ACPI sysfs convert work now. And I have some pr=
oblems when duplicating some procfs interfaces to sysfs.
> Under driver model (this will be available soon), files under /proc/a=
cpi/xxx(driver)/yyy(device)/ will be duplicated under /sys/device/ as t=
hey are properties of individual devices.
> But I still have some trouble on dealing with the files under /prco/a=
cpi, including =E2=80=9Calarm=E2=80=9D, =E2=80=9Csleep=E2=80=9D, =E2=80=
=9Cwakeup=E2=80=9D, =E2=80=9Cdebug_layer=E2=80=9D, =E2=80=9Cdebug_level=
=E2=80=9D, =E2=80=9Cdsdt=E2=80=9D, =E2=80=9Cfadt=E2=80=9D, =E2=80=9Ceve=
nt=E2=80=9D and =E2=80=9Cinfo=E2=80=9D.
> Following is a proposal as well as some problem and I=E2=80=99m not q=
uite sure about the places all these attributes should be located at. I=
 wish to get some advice from you, and any comment is welcome=E2=98=BA.
>=20
> 1. Where should =E2=80=9Calarm=E2=80=9D be located? Another problem i=
s whether we should put a duration into this file instead of a future t=
ime.
Don't know, never used...
> 2. =E2=80=9Csleep=E2=80=9D is already marked as deprecated because /s=
ys/power/state has the same function. I won=E2=80=99t do the repeated w=
ork again.
Yep.
> 3. =E2=80=9Cwakeup=E2=80=9D should not exist, but be an attribute of =
individual devices kobjects.
Maybe the devices can be linked
like /sys/.../wakeup/${links_to_wakeup_devices}
So that userspace does not need to search over the whole device tree to
find them?

> 4. =E2=80=9Cdebug_layer=E2=80=9D and =E2=80=9Cdebug_level=E2=80=9D ar=
e not decided yet. I think making them into two directories and locatin=
g them under /sys/bus/acpi is one choice.
> 5. Is =E2=80=9Cdsdt=E2=80=9D and =E2=80=9Cfadt=E2=80=9D still needed =
in sysfs? This is not necessary because the acpidump tools are quite ha=
ndy.
> If =E2=80=9CYes=E2=80=9D, are other tables also needed, e.g. multiple=
 SSDTs and dynamically loaded op-regions? This is much more difficult, =
as they can=E2=80=99t be distinguished sometimes.
> And where should these tables locate?
IMO they can vanish (at least temporarily).
If really needed (AFAIK explicitly loaded tables via "Load(addr,)"
statement that are not listed in RSDT/XSDT can't be found by acpidump),
a /sys/../tables/* can still be implemented at later time? We are also
not able to grab them atm...
> If the answer is =E2=80=9CNo=E2=80=9D, that=E2=80=99s good news for m=
e. =E2=98=BA.
> 6. =E2=80=9Cinfo=E2=80=9D shows the ACPICA version. Is it ok to regis=
ter =E2=80=9Cinfo=E2=80=9D as an attribute of ACPI bus kobject?

   Thomas


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
