From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Could not deliver interrupts to the PCI board
Date: Mon, 07 Mar 2005 10:12:17 -0700
Message-ID: <1110215537.21176.18.camel@eeyore>
References: <D02325A0F0177A468FD385A98178C53E0C3DF60A@SHAMLVEM01.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <D02325A0F0177A468FD385A98178C53E0C3DF60A-5f9O7Fn4wvickVo8Y7U6IZteJpo0ey06@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Feng (GE Healthcare)" <Feng.Li-sCFLEkgZW7GbXiaaNHstOg@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-03-07 at 10:50 +0800, Li, Feng (GE Healthcare) wrote:
>      I am trying to port our old pci drivers from Linux 2.4 kernel to Linux 2.6 kernel.
> Now i am working in Linux 2.6.11. I found a strange problem , after i installed the new driver(based on 2.6.11 kernel)
> into kernel, our pci device is recognized as IO-APIC-edge,  and no interrupts can be catched by our driver.( The PCI device shuold be a 
> IO-APIC-level type)

Make sure that your driver calls pci_enable_device() before
looking at dev->irq.  We now use that hook to do interrupt
routing (enable link devices, set to level triggered mode,
etc).

>      So we disabled the ACPI service and restart the computer again, then the pci device can be recognized as
> IO-APIC-level, the driver works well! I think,there are maybe some changes in 2.6.11 for ACPI sleep 
> and hibernate that essentially puts ACPI in control of interrupts for many devices.Should i  need to add ACPI 
> declaration data to the driver ?

You should not need to add any ACPI smarts to your driver if
it does the pci_enable_device() correctly.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
