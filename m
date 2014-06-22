From: Feng Tang <feng.tang@intel.com>
Subject: Re: [Patch V4 00/42] use irqdomain to dynamically allocate IRQ for
 IOAPIC
Date: Sun, 22 Jun 2014 23:02:12 +0800
Message-ID: <20140622150212.GB20551@feng-snb>
References: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com>
 <20140622084227.GA13974@gmail.com>
 <20140622143946.GA20551@feng-snb>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37618 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbaFVPEe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jun 2014 11:04:34 -0400
Content-Disposition: inline
In-Reply-To: <20140622143946.GA20551@feng-snb>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "Luck, Tony" <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, "Gortmaker, Paul (Wind River)" <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, alek.du@i

On Sun, Jun 22, 2014 at 10:39:46PM +0800, Feng Tang wrote:
> Hi,
>=20
> On Sun, Jun 22, 2014 at 04:42:27PM +0800, Ingo Molnar wrote:
> >=20
> > JFYI, with these patches applied x86 allyes32config fails with:
> >=20
> >   arch/x86/platform/intel-mid/device_libs/platform_wdt.c:45:3: erro=
r: implicit declaration of function =E2=80=98io_apic_set_pci_routing=E2=
=80=99=20
>=20
> In some intel-mid platforms (Medfield/Merrifield etc), the IOAPIC
> may have more than 80 pins, and some devices like a i2c based touch
> screen has its interrupt line directly connected to IOAPIC (this
> platform_wdt.c here should be the same case).
>=20
> Since these devices are not PCI device or ACPI device, they can't
> use the general PCI/ACPI xxx_enable_dev APIs which implicitly set
> up the ioapic entry, but use this "io_apic_set_pci_routing"
> directly.

Just quickly read Jiang's patch set, guess these driver should be ok
by using Jiang's new cleaner API "mp_set_gsi_attr()" to replace these
io_apic_set_pci_routing().

Thanks,
=46eng
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
