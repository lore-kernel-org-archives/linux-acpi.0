From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: Fri, 11 Mar 2005 09:48:05 -0700
Message-ID: <1110559685.4822.15.camel@eeyore>
References: <20050304234622.63e8a335.akpm@osdl.org>
	 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503110006260.30687-xO7mqm7LmoOZ0THcR2OzsA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-03-11 at 00:08 +0100, Grzegorz Kulewski wrote:
> Anything new about it?
> 
> Can I provide more usefull info?

Can you check to see whether there are any BIOS updates available
for your box?  It looks to me like your USB controllers are wired
to IRQ9, and that's how the BIOS is leaving them configured.

But ACPI is telling us they're on IRQ10, which seems like a BIOS
bug.

Can you also post the complete dmesg log without "acpi=off"?  There
might be an ACPI interrupt link device for the USB controller, and
maybe there's something wrong there.

> My log (2.6.11 without acpi=off):
> Mar  2 23:36:56 kangur USB Universal Host Controller Interface driver v2.2
> Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: irq 10, io base 0xc800
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> Mar  2 23:36:56 kangur hub 1-0:1.0: USB hub found
> Mar  2 23:36:56 kangur hub 1-0:1.0: 2 ports detected
> Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: irq 10, io base 0xcc00
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> Mar  2 23:36:56 kangur hub 2-0:1.0: USB hub found
> Mar  2 23:36:56 kangur hub 2-0:1.0: 2 ports detected

> My log (2.6.11 with acpi=off):
> Mar  3 01:45:48 kangur USB Universal Host Controller Interface driver v2.2
> Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:07.2
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.3
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:0b.0
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: irq 9, io base 0xc800
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> Mar  3 01:45:48 kangur hub 1-0:1.0: USB hub found
> Mar  3 01:45:48 kangur hub 1-0:1.0: 2 ports detected
> Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:07.3
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.2
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:0b.0
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: irq 9, io base 0xcc00
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> Mar  3 01:45:48 kangur hub 2-0:1.0: USB hub found
> Mar  3 01:45:48 kangur hub 2-0:1.0: 2 ports detected




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
