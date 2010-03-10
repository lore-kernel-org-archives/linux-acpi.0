From: Pauli Nieminen <suokkos@gmail.com>
Subject: Re: [Q] How to tell we're using the KMS (during suspend/resume)
	outside the graphics driver
Date: Wed, 10 Mar 2010 12:54:46 +0200
Message-ID: <548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
References: <201003062236.09801.rjw@sisk.pl> <201003091234.59598.rjw@sisk.pl>
	 <alpine.LFD.2.00.1003091613390.30952@casper.infradead.org>
	 <201003092208.28175.rjw@sisk.pl> <20100310055013.GC19518@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100310055013.GC19518@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 10, 2010 at 7:50 AM, Paul Mundt <lethal@linux-sh.org> wrote=
:
> On Tue, Mar 09, 2010 at 10:08:28PM +0100, Rafael J. Wysocki wrote:
>> On Tuesday 09 March 2010, James Simmons wrote:
>> >
>> > > > > Second, in the KMS case, we'd be able to skip the kernel VT =
switch, because
>> > > > > the KMS driver uses its own framebuffer anyway.
>> > > > >
>> > > > > So, is there any reasonable way to check that from the outsi=
de of the graphics
>> > > > > driver? =A0It should be general enough to cover the cases wh=
en there are two
>> > > > > graphics adapters with different drivers in the system and s=
o forth.
>> > > >
>> > > > Inside the kernel? If you have a struct pci_dev you can get th=
e
>> > > > associated struct drm_device with pci_get_drvdata and then che=
ck the
>> > > > KMS feature: drm_core_check_feature(dev, DRIVER_MODESET).
>> > >
>> > > Yeah, I know that.
>> > >
>> > > > I'm note sure how to check that a device is graphic card thoug=
h :|
>> > >
>> > > Well, that's the "outside of the graphics driver" part of my que=
stion. :-)
>> >
>> > if ((pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
>> > =A0 =A0 ....
>>
>> I'm not sure if searching through all PCI devices really is an optio=
n.
>>
> Why not? The VGA arbitration code tracks a list of VGA class devices,=
 so
> could easily be queried. It looks like it might need a bit more work =
for
> PCI hotplug, but it should already have all of the infrastructure you
> need for getting at the pdev for the suspend/resume case.
>
>

It would be better to add interface that can be used to query if a
graphic device supports KMS. This should support multi-gpu setups at
least. I don't think anything prevents running mixed system where
secundary gpu is driven by UMS code in X.

Are you sure that all vga class devices have private device data that
matches private drm_device structure?
