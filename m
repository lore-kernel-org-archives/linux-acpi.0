From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/6] ACPI: Replace struct acpi_bus_ops with enum type
Date: Wed, 12 Dec 2012 23:39:12 +0100
Message-ID: <20863259.Bu9Is6dGkB@vostro.rjw.lan>
References: <8498184.VilrUmatxI@vostro.rjw.lan> <50C89608.7050908@gmail.com> <50C89D2B.4060206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50C89D2B.4060206@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Yijing Wang <wangyijing0307@gmail.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, December 12, 2012 11:05:15 PM Jiang Liu wrote:
> On 12/12/2012 10:34 PM, Yijing Wang wrote:
> > =E4=BA=8E 2012-12-12 2:30, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >> Hi Gerry,
> >>
> >> On Tuesday, December 11, 2012 11:09:06 PM Jiang Liu wrote:
> >>> Hi Rafael,
> >>> 	I have worked out a patch set to clean up ACPI/PCI related notif=
ications,
> >>> please refer to
> >>> http://www.spinics.net/lists/linux-pci/msg17822.html
> >>> 	The patchset doesn't apply cleanly to Bjorn's latest pci-next tr=
ee. I will
> >>> help to rebase it if needed.
> >>
> >> I have reviewed the patches and I think they make sense overall.  =
However,
> >> the statement that acpi_pci_bind()/acpi_pci_unbind() are used to m=
aintain
> >> PCI-ACPI binding relationships is quite inaccurate, because all wh=
at these
> >> functions do is to (1) add/remove ACPI PM notifiers to/from PCI de=
vices and
> >> (2) retrieve the _PRT information for bridges from ACPI tables.  I=
n fact,
> >> the *binding* itself is managed by the code in drivers/acpi/glue.c=
=2E
> >>
> >> Also, please have a look at my suggestion in the last reply to Yin=
ghai:
> >>
> >> http://marc.info/?l=3Dlinux-pci&m=3D135522965707752&w=3D2
> >>
> >> In fact, I think we can go even further than that.  Namely, if we =
populate the
> >> ACPI handle of the device in pci_scan_device(), then we can just m=
ove the PM
> >> notifier and wakeup setup to platform_pci_wakeup_init(), where it =
should be
> >> (we'll also need to add a corresponding _exit() function, then, bu=
t that'll be
> >> much cleaner anyway).
> >>
> >> Then, the remaining thing would be to ensure that _PRT entries are=
 parsed
> >> as appropriate somewhere around pci_init_capabilities().
> >>
> >> Also, I wonder if you can help test the $subject patchset on a sys=
tem with
> >> hardware PCI hotplug (preferably on top of the linux-pm.git/master=
 branch)?
> >>
> > Hi Rafael,
> >    We are doing test for this series patches, I will send out the t=
est result as soon.
> Hi Rafael,
> 	We have tried to merge your patchset with IOH hotplug patchsets from=
 Yinghai,
> and obviously it's not a ease task and we have run into panics. We wi=
ll try to find
> some ways to test your patchset only next step.

Thanks a lot for doing this, really appreciated!

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
