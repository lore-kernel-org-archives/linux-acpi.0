From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 2/6] ACPI, PCI: Notify acpi_pci_drivers when
 hot-plugging PCI root bridges
Date: Tue, 4 Sep 2012 22:01:59 -0700
Message-ID: <CAE9FiQUbfTivsyYJe0cr-Dng2+3wEXMM7TX+RgxNC+mGBok6Kw@mail.gmail.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
	<20120903170442.c406455c.izumi.taku@jp.fujitsu.com>
	<4A338DB2991D2A44B9A44B8718AECF650A4A2DCD@G01JPEXMBYT03>
	<CAE9FiQVJ0JRCgZsh+iSB8VC4TqJDcetPyno36L8=UW-UQUK4vQ@mail.gmail.com>
	<4A338DB2991D2A44B9A44B8718AECF650A4A4240@G01JPEXMBYT03>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4A338DB2991D2A44B9A44B8718AECF650A4A4240@G01JPEXMBYT03>
Sender: linux-pci-owner@vger.kernel.org
To: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
Cc: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 4, 2012 at 9:32 PM, Kaneshige, Kenji
<kaneshige.kenji@jp.fujitsu.com> wrote:
>
> Ok, my understanding of your comment is that IOAPIC and DMAR drivers are implemented
> as ACPI PCI driver (or you have a plan to implement IOAPIC and DMAR drivers as ACPI
> PCI driver), and those drivers need to be loaded before PCI device drivers. Is my
> understanding correct?

yes.

for ioapic:
http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-x86-irq

for iommu:
http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-iommu

Thanks

Yinghai
