From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] VIA IRQ quirk for 2.6.12-rc5
Date: Fri, 27 May 2005 11:09:17 +0100
Message-ID: <1117188546.5730.175.camel@localhost.localdomain>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050527082150.GA24428-g3qfMnKXm6l/wjb6y0L7XlrsPObopucw0e7PPNI6Mm0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <lenb-g3qfMnKXm6l/wjb6y0L7XlrsPObopucw0e7PPNI6Mm0@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Gwe, 2005-05-27 at 09:21, Len Brown wrote:
> Delete quirk_via_bridge(), restore quirk_via_irqpic() --
> but now improved to be invoked upon device ENABLE, and
> now only for VIA devices -- not all devices behind VIA bridges.

Properly you should apply the fixup to all VBUS devices. I've not seen a
clean way to identify which devices fall into that category but there
are public 
data sheets for many of the chips.

> +		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
> +			pci_name(dev), irq, new_irq);
> +		udelay(15);	/* unknown if delay really needed */
> +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);

It isn't



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
