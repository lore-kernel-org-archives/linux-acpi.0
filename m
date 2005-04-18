From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Fw: Re: 2.6.12-rc2-mm2
Date: Mon, 18 Apr 2005 09:41:09 -0600
Message-ID: <1113838869.28727.5.camel@eeyore>
References: <16A54BF5D6E14E4D916CE26C9AD30575019C29C7@pdsmsx402.ccr.corp.intel.com>
	 <425AA4C1.6050609@gmail.com> <1113322633.17684.23.camel@eeyore>
	 <425C330B.9000806@gmail.com>  <1113340363.17684.69.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1113340363.17684.69.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Thonke <iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Nguyen, Tom L" <tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I didn't see any activity on this.  Did I miss it, or did it
get resolved somehow?

On Tue, 2005-04-12 at 15:12 -0600, Bjorn Helgaas wrote:
> On Tue, 2005-04-12 at 22:43 +0200, Michael Thonke wrote:
> > Okay I irgnored all the ACPI messages blowing ower my screen.
> > The NVidia PCIe 6600GT doesn't work, i tried it with an ATI PCIe X800pro
> > but the same result both
> > graphic adapters won't work.
> 
> OK, let's see if we can figure out more specifically what's broken.
> 
> A 2.6.12-rc2 dmesg log from a previous post included this:
> 
> 	nvidia: module license 'NVIDIA' taints kernel.
> 	ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
> 	PCI: Setting latency timer of device 0000:04:00.0 to 64
> 
> The 2.6.12-rc2-mm2 dmesg from that post doesn't mention nvidia.  Was
> the nvidia module loaded (check with "lsmod")?  Does it produce any
> dmesg output when it loads?  Does the output of "lspci -vvs04:00.0"
> look different between 2.6.12-rc2 and 2.6.12-rc2-mm2?
> 
> > The Marvell sometimes not work after boot.
> > The driver sk98lin 8.16.2.3 loaded normally, but I can't get them up
> > with ifconfig.
> 
> What sort of error do you see when the Marvell doesn't work?  The
> previous dmesg logs both contain this:
> 
> 	sk98lin: Network Device Driver v8.15.1.3
> 	(C)Copyright 1999-2005 Marvell(R).
> 	ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 201
> 	PCI: Setting latency timer of device 0000:02:00.0 to 64
> 	eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
> 	      PrefPort:A  RlmtMode:Check Link State
> 
> When it doesn't work, is there something different logged?
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
