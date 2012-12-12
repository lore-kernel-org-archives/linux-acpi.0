From: Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH 5/6] ACPI: Replace struct acpi_bus_ops with enum type
Date: Wed, 12 Dec 2012 23:05:15 +0800
Message-ID: <50C89D2B.4060206@gmail.com>
References: <8498184.VilrUmatxI@vostro.rjw.lan> <CAE9FiQXYPPcRZZBFGrqcV--0-UixMH1f+q4WdovErthsLhxn7A@mail.gmail.com> <50C74C92.1040405@gmail.com> <2093499.q2b9fD3smR@vostro.rjw.lan> <50C89608.7050908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43047 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab2LLPFb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Dec 2012 10:05:31 -0500
In-Reply-To: <50C89608.7050908@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yijing Wang <wangyijing0307@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>

On 12/12/2012 10:34 PM, Yijing Wang wrote:
> =E4=BA=8E 2012-12-12 2:30, Rafael J. Wysocki =E5=86=99=E9=81=93:
>> Hi Gerry,
>>
>> On Tuesday, December 11, 2012 11:09:06 PM Jiang Liu wrote:
>>> Hi Rafael,
>>> 	I have worked out a patch set to clean up ACPI/PCI related notific=
ations,
>>> please refer to
>>> http://www.spinics.net/lists/linux-pci/msg17822.html
>>> 	The patchset doesn't apply cleanly to Bjorn's latest pci-next tree=
=2E I will
>>> help to rebase it if needed.
>>
>> I have reviewed the patches and I think they make sense overall.  Ho=
wever,
>> the statement that acpi_pci_bind()/acpi_pci_unbind() are used to mai=
ntain
>> PCI-ACPI binding relationships is quite inaccurate, because all what=
 these
>> functions do is to (1) add/remove ACPI PM notifiers to/from PCI devi=
ces and
>> (2) retrieve the _PRT information for bridges from ACPI tables.  In =
fact,
>> the *binding* itself is managed by the code in drivers/acpi/glue.c.
>>
>> Also, please have a look at my suggestion in the last reply to Yingh=
ai:
>>
>> http://marc.info/?l=3Dlinux-pci&m=3D135522965707752&w=3D2
>>
>> In fact, I think we can go even further than that.  Namely, if we po=
pulate the
>> ACPI handle of the device in pci_scan_device(), then we can just mov=
e the PM
>> notifier and wakeup setup to platform_pci_wakeup_init(), where it sh=
ould be
>> (we'll also need to add a corresponding _exit() function, then, but =
that'll be
>> much cleaner anyway).
>>
>> Then, the remaining thing would be to ensure that _PRT entries are p=
arsed
>> as appropriate somewhere around pci_init_capabilities().
>>
>> Also, I wonder if you can help test the $subject patchset on a syste=
m with
>> hardware PCI hotplug (preferably on top of the linux-pm.git/master b=
ranch)?
>>
> Hi Rafael,
>    We are doing test for this series patches, I will send out the tes=
t result as soon.
Hi Rafael,
	We have tried to merge your patchset with IOH hotplug patchsets from Y=
inghai,
and obviously it's not a ease task and we have run into panics. We will=
 try to find
some ways to test your patchset only next step.
	Thanks!

>=20
> Thanks!
> Yijing
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
