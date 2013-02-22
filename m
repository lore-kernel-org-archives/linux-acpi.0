From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: PCI D3 wakeup failure on Lynx Point xHCI
Date: Fri, 22 Feb 2013 01:01:05 +0100
Message-ID: <4173055.L3bittasFp@vostro.rjw.lan>
References: <20130221214145.GA25639@xanatos> <2088156.nL7UmaIX3H@vostro.rjw.lan> <20130221235211.GC32050@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130221235211.GC32050@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Huang Ying <ying.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, February 21, 2013 03:52:11 PM Sarah Sharp wrote:
> On Thu, Feb 21, 2013 at 11:54:55PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 21, 2013 01:41:45 PM Sarah Sharp wrote:
> > > Hi Rafael,
> > 
> > Hi,
> >  
> > > I'm running into some issues with PCI D3
> > 
> > Do you mean D3hot?
> 
> I don't think this PCI device supports D3cold.  At least that's what the
> hardware folks tell me.  However, the lspci output wasn't clear which
> state the PCI device was in.  If I cat
> /sys/bus/pci/devices/0000:00:14.0/d3cold_allowed, it says '1', however I
> don't see any output in dmesg that says the device was put in D3cold.
> 
> > In addition to that you can see if the number of ACPI interrupts (in
> > /proc/interrupts) grows when you plug the USB device in and if so,
> > whether or not any of the numbers in /sys/firmware/acpi/interrupts/gpe*
> > grows at the same time.
> 
> In /proc/interrupts, the xHCI MSI line does not change when I plug in a
> device while the PCI device is in D3:
> 
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       
>   0:         70          0          0          0          0          0          0          0  IR-IO-APIC-edge      timer
>   1:       5424          0          0          0          0          0          0          0  IR-IO-APIC-edge      i8042
>   8:          1          0          0          0          0          0          0          0  IR-IO-APIC-edge      rtc0
>   9:       1745        544          0          0          0          0          0          0  IR-IO-APIC-fasteoi   acpi
>  12:      22823          0          0          0          0          0          0          0  IR-IO-APIC-edge      i8042
>  16:       1009          0          0          0          0          0          0          0  IR-IO-APIC-fasteoi   ehci_hcd:usb3, nouveau
>  17:        299          0          0          0          0          0          0          0  IR-IO-APIC-fasteoi   snd_hda_intel
>  19:         26          0          9          0          0          0          0          0  IR-IO-APIC-fasteoi 
>  23:        956         99          0          0          0          0          0          0  IR-IO-APIC-fasteoi   ehci_hcd:usb4
>  40:          0          0          0          0          0          0          0          0  DMAR_MSI-edge      dmar0
>  41:          0          0          0          0          0          0          0          0  IR-PCI-MSI-edge      PCIe PME
>  42:          0          0          0          0          0          0          0          0  IR-PCI-MSI-edge      PCIe PME
>  43:          0          0          0          0          0          0          0          0  IR-PCI-MSI-edge      PCIe PME, pciehp
>  44:      27450          0          0          0          0          0          0          0  IR-PCI-MSI-edge      ahci
>  45:         38          0          0          0          0          0          0          0  IR-PCI-MSI-edge      xhci_hcd
>  46:       6065          0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth5
>  47:         26          0          0          0          0          0          0          0  IR-PCI-MSI-edge      mei
>  48:        246          0          0         59          0          0          0          0  IR-PCI-MSI-edge      snd_hda_intel
> NMI:         14          6         13          9          2          2          3          4   Non-maskable interrupts
> LOC:     130457     125777      99012      92995      39437      36596      28275      30074   Local timer interrupts
> SPU:          0          0          0          0          0          0          0          0   Spurious interrupts
> PMI:         14          6         13          9          2          2          3          4   Performance monitoring interrupts
> IWI:          1          1          1          1          0          0          0          0   IRQ work interrupts
> RTR:          0          0          0          0          0          0          0          0   APIC ICR read retries
> RES:      25303      11329       1532        782        513        432        427        350   Rescheduling interrupts
> CAL:        542        693        748        672        762        767        803        754   Function call interrupts
> TLB:        908        783        781        817       1087       1530       1355       1261   TLB shootdowns
> TRM:          0          0          0          0          0          0          0          0   Thermal event interrupts
> THR:          0          0          0          0          0          0          0          0   Threshold APIC interrupts
> MCE:          0          0          0          0          0          0          0          0   Machine check exceptions
> MCP:          7          7          7          7          7          7          7          7   Machine check polls
> ERR:          0
> MIS:          0
> 
> However, /sys/firmware/acpi/interrupts/gpe0D changes.  The file seems to
> indicate the GPE is enabled (it reads as "5 enabled" after some
> hotplug tests).

It looks like the event is signaled, then.

> ACPI tables are attached.

Thanks, I'll have a look at that tomorrow.

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
