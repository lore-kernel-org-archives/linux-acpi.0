From: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.8.1-mm1 hangs on boot with ACPI
Date: 19 Aug 2004 02:49:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1092898173.25911.224.camel@dhcppc4>
References: <566B962EB122634D86E6EE29E83DD808182C35CE@hdsmsx403.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268095AbUHSGuE@vger.kernel.org>
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C35CE@hdsmsx403.hd.intel.com>
To: Pontus Fuchs <pontus.fuchs@tactel.se>
Cc: linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-08-17 at 04:55, Pontus Fuchs wrote:
> Hi,
> 
> After upgrading to 2.6.8.1-mm1 from plain 2.6.8.1 my machine does not
> boot anymore. The last message i see is:
> 
> ACPI: Processor [CPU0] (supports C1,C2,C3, 8 throttling states)
> 
> In plain 2.6.8.1 the next messages would be:
> 
> ACPI: Thermal Zone [THRM] (52 C)
> Console: switching to colour frame buffer device 175x65
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected SiS 648 chipset
> 
> Booting with acpi=off works fine. I have also tried pci=routeirq but
> it
> does not make any difference.
> 
> The machine is an Asus L5c laptop.

Please try booting with "pci=routeirq"
If that doesn't work, please take stock 2.6.8.1 and apply the latest
patch here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/
and give it a go.

This will bring your kernel up to the same ACPI patch that is in the -mm
tree, but without all the other stuff in the mm tree.

If it fails, then ACPI broke.  If it works, then something in -mm broke
ACPI.

thanks,
-Len
