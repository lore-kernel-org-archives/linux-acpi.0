From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [Q] How to tell we're using the KMS (during suspend/resume)
	outside the graphics driver
Date: Tue, 6 Apr 2010 09:47:50 +0200
Message-ID: <q2xb170af451004060047t7b661f63p903d4bd7452a1e45@mail.gmail.com>
References: <201003062236.09801.rjw@sisk.pl>
	 <548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
	 <20100310205618.GA28628@srcf.ucam.org>
	 <201003102215.26232.rjw@sisk.pl>
	 <20100310211704.GA29201@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100310211704.GA29201@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pauli Nieminen <suokkos@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

2010/3/10 Matthew Garrett <mjg59@srcf.ucam.org>:
> On Wed, Mar 10, 2010 at 10:15:26PM +0100, Rafael J. Wysocki wrote:
>> On Wednesday 10 March 2010, Matthew Garrett wrote:
>> > As far as the ACPI video driver goes, acpi_get_physical_pci_device=
()
>> > will give you something to work with.
>>
>> Hmm. =C2=A0Did you mean acpi_get_physical_device()?
>
> Ah, no, acpi_get_pci_dev.

So, AFAIU acpi_get_pci_dev will give me pointer to struct pci_dev of
video card, yes?

There is some path I could use then:

struct pci_dev {
    .....
    struct pci_driver *driver;	/* which driver has allocated this devic=
e */
    .....
}

struct pci_driver {
    .....
    struct device_driver	driver;
    .....
}

=46inally, struct device_driver is defined in device.h. Should I add fl=
ag
bool is_kms
to this struct then?

AFAIK we can not do anything with struct driver_private *p... Or is
there unified struct for video card drivers? We could then add flag
is_kms to some struct pointed by struct driver_private *p.

--=20
Rafa=C5=82
