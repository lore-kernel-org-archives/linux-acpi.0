From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: Re: [linux-usb-devel] Fw: [Bugme-new] [Bug 4325] New: freeze
 under load - system partialy continues working but no response on
 keyboard/mouse
Date: Fri, 11 Mar 2005 12:18:03 -0800
Message-ID: <20050311121803.3ec3a012.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I think this one might be an ACPI problem?

Begin forwarded message:

Date: Fri, 11 Mar 2005 11:29:36 -0800
From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
To: linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, stryhal-GXikQ/4b6Y3rBKCeMvbIDA@public.gmane.org
Subject: Re: [linux-usb-devel] Fw: [Bugme-new] [Bug 4325] New: freeze under load - system partialy continues working but no response on keyboard/mouse


On Friday 11 March 2005 1:49 am, Andrew Morton wrote:
> 
> 
> http://bugme.osdl.org/show_bug.cgi?id=4325
> ...
> 
> HID: (in non conflicting port)
> usb 3-1.1: new low speed USB device using ohci_hcd and address 3
> usb 3-1.2: new low speed USB device using ohci_hcd and address 4
> input: USB HID v1.00 Mouse [KYE Genius USB Wheel Mouse] on usb-0000:00:02.1-1.1
> input: USB HID v1.10 Keyboard [CHICONY USB Keyboard] on usb-0000:00:02.1-1.2
> 
> interrupts:
>                                                                                
>               0:    4440474    IO-APIC-edge  timer                             
>   2:          0          XT-PIC  cascade                                       
>   3:       1193    IO-APIC-edge  NVidia nForce2                                
> ****** probably the problem ?? ******
>   5:      27926    IO-APIC-edge  ohci1394, ohci_hcd:usb2, eth0                 

I assume otherwise, since it said above that the device is on "usb3"!


> *************************************
>   8:      27042    IO-APIC-edge  rtc                                           
>   9:          0          XT-PIC  ehci_hcd:usb1                                 
>  11:      59151    IO-APIC-edge  libata, ohci_hcd:usb3

One thing that seems fairly obviously broken is the assignment of
the OHCI hardware to an edge triggered IRQ.  So far as I know, all
OHCI controllers are level triggered.  And FWIW I have an NF2 box
here, which assigns OHCI to IRQs #20 and #22, EHCI to IRQ #22, and
eth0 (forcedeth) to share IRQ #22 ... all level triggered..


>  14:         19    IO-APIC-edge  ide0                                          
>  15:       4506    IO-APIC-edge  ide1                                          
>  19:     200000   IO-APIC-level  radeon@PCI:2:0:0                              
> NMI:          0                                                                
> LOC:    4440242                                                                
> ERR:          0                                                                
> MIS:          0

So basically this looks like whatever is setting up your IRQs
is borked ...


Related issue, I think that the Linux IRQ framework needs
much better handling of level vs edge stuff.  It should be
possible for drivers to specify level triggering (vs rising
edge, falling edge, etc); they know what the hardware does,
better than any generic infrastructure.  The fact that it's
even possible to get the wrong type of IRQ triggering says
to me that the API is deficient.  (Another thing saying that
is noticing that ARM needs API extensions in that area.)

- Dave


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
