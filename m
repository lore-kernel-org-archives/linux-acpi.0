From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [RFT][PATCH] PCI / ACPI: Do not require MSI support for PCIe
 native features
Date: Wed, 16 Mar 2011 22:23:32 -0700
Message-ID: <AANLkTim39fjrAp4OW_MfpbZkz-YYW5E2NOHuo1j=svmW@mail.gmail.com>
References: <201103052254.48515.rjw@sisk.pl>
	<201103150100.17501.rjw@sisk.pl>
	<20110315190545.GA4165@xanatos>
	<201103170119.17647.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201103170119.17647.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

2011/3/16 Rafael J. Wysocki <rjw@sisk.pl>:
> On Tuesday, March 15, 2011, Sarah Sharp wrote:
>> On Tue, Mar 15, 2011 at 01:00:17AM +0100, Rafael J. Wysocki wrote:
>> > Well, I must admit I have no idea what the problem is. =A0OK, in a=
ddition to the
>> > above changes, please replace the "pci_ext_cfg_avail(root->bus->se=
lf)" in the
>> > same file with "true" and see if _that_ helps.
>>
>> Yay, that worked! =A0dmesg is attached.
>
> Good, at least we know what the problem is, now we only have to find =
the root
> cause. ;-)
>
> So, pci_ext_cfg_avail(root->bus->self) returns 0 on your machine, whi=
ch is kind
> of unexpected (to put it lightly), so very likely we have uncovered a=
 bug
> in the init code.
>
> Unfortunately, I may not be able to take care of this issue for the n=
ext few
> days, I'll let you know when I get back to it.

her .config does not define PCI_MMCONFIG

#
# Bus options (PCI etc.)
#
CONFIG_PCI=3Dy
CONFIG_PCI_DIRECT=3Dy
# CONFIG_PCI_MMCONFIG is not set

Yinghai
