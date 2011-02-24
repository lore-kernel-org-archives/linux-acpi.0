From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] x86/pci: derive pcibios_last_bus from ACPI MCFG
Date: Thu, 24 Feb 2011 09:47:07 -0700
Message-ID: <201102240947.07596.bjorn.helgaas@hp.com>
References: <4D64EA9A0200007800033430@vpn.id2.novell.com> <201102231400.54417.bjorn.helgaas@hp.com> <20110223131544.19260532@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20110223131544.19260532@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Jan Beulich <JBeulich@novell.com>, mingo@elte.hu, tglx@linutronix.de, linux-pci@vger.kernel.org, hpa@zytor.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 23, 2011 02:15:44 pm Jesse Barnes wrote:
> 
> But maybe using MCFG's bus numbers *is* the canonical way of getting
> the max bus...  I don't know what Windows does here, but I can imagine
> that it exposes all these devices to various drivers.  Perhaps they're
> hidden so that earlier versions of Windows won't "yellow bang" the
> unknown devices, while newer versions use MCFG.

[I added linux-acpi to the cc: list.]

MCFG is for communicating memory-mapped configuration space addresses.
I don't see anything in the specs about getting bus numbers from it.

I would think _CRS is the canonical way of getting bus ranges because:

  - PNP0A03/08 devices have _CRS indicating bus range
    [PCI Firmware 3.0, sec 4.3.2.1].

  - PNP0A03 devices (PCI or PCI-X host bridges) need not support
    the enhanced configuration access mechanism, so wouldn't need
    MCFG, but we still need the bus range.

  - DIG64 systems may have PNP0A08 devices but no MCFG, but again,
    we still need the bus range [PCI Firmware 3.0, sec. 4.1.5].

> Does anyone have an affected machine with Windows 7 or something so we
> can verify?

If we added MCFG support to qemu, it should be pretty easy to see how
Windows handles it, but I'm not in a position to do that right now.

Bjorn
