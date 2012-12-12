From: Yijing Wang <wangyijing0307@gmail.com>
Subject: Re: [PATCH 5/6] ACPI: Replace struct acpi_bus_ops with enum type
Date: Wed, 12 Dec 2012 22:34:48 +0800
Message-ID: <50C89608.7050908@gmail.com>
References: <8498184.VilrUmatxI@vostro.rjw.lan> <CAE9FiQXYPPcRZZBFGrqcV--0-UixMH1f+q4WdovErthsLhxn7A@mail.gmail.com> <50C74C92.1040405@gmail.com> <2093499.q2b9fD3smR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2093499.q2b9fD3smR@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: linux-acpi@vger.kernel.org

=E4=BA=8E 2012-12-12 2:30, Rafael J. Wysocki =E5=86=99=E9=81=93:
> Hi Gerry,
>=20
> On Tuesday, December 11, 2012 11:09:06 PM Jiang Liu wrote:
>> Hi Rafael,
>> 	I have worked out a patch set to clean up ACPI/PCI related notifica=
tions,
>> please refer to
>> http://www.spinics.net/lists/linux-pci/msg17822.html
>> 	The patchset doesn't apply cleanly to Bjorn's latest pci-next tree.=
 I will
>> help to rebase it if needed.
>=20
> I have reviewed the patches and I think they make sense overall.  How=
ever,
> the statement that acpi_pci_bind()/acpi_pci_unbind() are used to main=
tain
> PCI-ACPI binding relationships is quite inaccurate, because all what =
these
> functions do is to (1) add/remove ACPI PM notifiers to/from PCI devic=
es and
> (2) retrieve the _PRT information for bridges from ACPI tables.  In f=
act,
> the *binding* itself is managed by the code in drivers/acpi/glue.c.
>=20
> Also, please have a look at my suggestion in the last reply to Yingha=
i:
>=20
> http://marc.info/?l=3Dlinux-pci&m=3D135522965707752&w=3D2
>=20
> In fact, I think we can go even further than that.  Namely, if we pop=
ulate the
> ACPI handle of the device in pci_scan_device(), then we can just move=
 the PM
> notifier and wakeup setup to platform_pci_wakeup_init(), where it sho=
uld be
> (we'll also need to add a corresponding _exit() function, then, but t=
hat'll be
> much cleaner anyway).
>=20
> Then, the remaining thing would be to ensure that _PRT entries are pa=
rsed
> as appropriate somewhere around pci_init_capabilities().
>=20
> Also, I wonder if you can help test the $subject patchset on a system=
 with
> hardware PCI hotplug (preferably on top of the linux-pm.git/master br=
anch)?
>=20
Hi Rafael,
   We are doing test for this series patches, I will send out the test =
result as soon.

Thanks!
Yijing
