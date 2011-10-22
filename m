From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / ACPI: Make acpiphp ignore root bridges using PCIe native hotplug
Date: Sun, 23 Oct 2011 00:10:37 +0200
Message-ID: <201110230010.37802.rjw@sisk.pl>
References: <201110220043.38635.rjw@sisk.pl> <CAE9FiQUxuajrqka97M_tvbXoMSzPTBGyjiBib_EG4MjRTuNmFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQUxuajrqka97M_tvbXoMSzPTBGyjiBib_EG4MjRTuNmFQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday, October 22, 2011, Yinghai Lu wrote:
> On Fri, Oct 21, 2011 at 3:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > If the kernel has requested control of the PCIe native hotplug
> > feature for a given root complex, the acpiphp driver should not try
> > to handle that root complex and it should leave it to pciehp.
> > Failing to do so causes problems to happen if acpiphp is loaded
> > before pciehp on such systems.
> 
> Should pciehp be built-in kernel instead of as a module?

Well, perhaps.  Still, though, if someone doesn't build pciehp and
the control of the native PCIe hotplug is granted for a given root
complex, acpiphp won't work anyway.

Thanks,
Rafael
