From: Pontus Fuchs <pontus.fuchs@tactel.se>
Subject: Re: 2.6.8.1-mm1 hangs on boot with ACPI
Date: Thu, 19 Aug 2004 10:10:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1092903048.6392.7.camel@dhcp-225.mlm.tactel.se>
References: <566B962EB122634D86E6EE29E83DD808182C35CE@hdsmsx403.hd.intel.com>
	 <1092898173.25911.224.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263769AbUHSILV@vger.kernel.org>
In-Reply-To: <1092898173.25911.224.camel@dhcppc4>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-08-19 at 08:49, Len Brown wrote:
> > After upgrading to 2.6.8.1-mm1 from plain 2.6.8.1 my machine does not
> > boot anymore. The last message i see is:
> > 
> > ACPI: Processor [CPU0] (supports C1,C2,C3, 8 throttling states)
> > 
> > In plain 2.6.8.1 the next messages would be:
> > 
> > ACPI: Thermal Zone [THRM] (52 C)
> > Console: switching to colour frame buffer device 175x65
> > Linux agpgart interface v0.100 (c) Dave Jones
> > agpgart: Detected SiS 648 chipset
> > 
> > Booting with acpi=off works fine. I have also tried pci=routeirq but
> > it
> > does not make any difference.
> > 
> > The machine is an Asus L5c laptop.
> 
> Please try booting with "pci=routeirq"
> If that doesn't work, please take stock 2.6.8.1 and apply the latest
> patch here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/
> and give it a go.
> 
> This will bring your kernel up to the same ACPI patch that is in the -mm
> tree, but without all the other stuff in the mm tree.
> 
> If it fails, then ACPI broke.  If it works, then something in -mm broke
> ACPI.

Hi,

I did what you suggested but the kernel still hangs. I have put the
details on bugme.osdl.org:

http://bugme.osdl.org/show_bug.cgi?id=3233

Pontus Fuchs
