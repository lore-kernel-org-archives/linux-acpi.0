From: Matthew Wilcox <willy@debian.org>
Subject: Re: [ACPI] [patch] 2.6.7-rc2-mm1: let SERIAL_8250_ACPI depend on ACPI_PCI
Date: Wed, 2 Jun 2004 12:27:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040602112716.GS5850@parcelfarce.linux.theplanet.co.uk>
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602003938.GJ25681@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S261875AbUFBL1t@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040602003938.GJ25681@fs.tum.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 02, 2004 at 02:39:39AM +0200, Adrian Bunk wrote:
>   CC      drivers/serial/8250_acpi.o
> drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
> drivers/serial/8250_acpi.c:61: warning: implicit declaration of function `acpi_register_gsi'
> 
> It seems the following is required:
> 
>  config SERIAL_8250_ACPI
>  	bool "8250/16550 device discovery via ACPI namespace"
>  	default y if IA64
> -	depends on ACPI_BUS && SERIAL_8250
> +	depends on ACPI_PCI && SERIAL_8250
>  	---help---

Hmm.  It's *morally* wrong since there's really no requirement that
a machine with ACPI serial should have PCI ... but on the other hand,
we're unlikely to see a machine without PCI that requires us to discover
ACPI serial ports.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
