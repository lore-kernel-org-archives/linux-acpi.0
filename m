From: Michael Thonke <iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: Re: 2.6.12-rc2-mm2
Date: Tue, 12 Apr 2005 22:43:55 +0200
Message-ID: <425C330B.9000806@gmail.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575019C29C7@pdsmsx402.ccr.corp.intel.com>	 <425AA4C1.6050609@gmail.com> <1113322633.17684.23.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1113322633.17684.23.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Nguyen, Tom L" <tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bjorn Helgaas schrieb:

>On Mon, 2005-04-11 at 18:24 +0200, Michael Thonke wrote:
>  
>
>>It first consider that no bus supports ACPI, but than it say ACPI supported.
>>Maybe I interpret it in the wrong way. I hope you will/can fnd what is
>>wrong.
>>...
>>This message 1st spotted over the screen:
>>    ACPI: No ACPI bus support for 00:00
>>    ACPI: No ACPI bus support for 00:01
>>    ACPI: No ACPI bus support for 00:02
>>    ACPI: No ACPI bus support for 00:03
>>    ACPI: No ACPI bus support for 00:04
>>    ACPI: No ACPI bus support for 00:05
>>    ACPI: No ACPI bus support for 00:06
>>    ACPI: No ACPI bus support for 00:07
>>    ACPI: No ACPI bus support for 00:08
>>    ACPI: No ACPI bus support for 00:09
>>    ACPI: No ACPI bus support for 00:0a
>>    ACPI: No ACPI bus support for 00:0b
>>
>>And then for each pcie port:
>>    ACPI: No ACPI bus support for pcie00-03
>>    
>>
>
>The messages above are harmless, so you can ignore them.
>ACPI is in fact supported and working in spite of these
>messages.
>
>  
>
>>After that this appears:
>>    ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 201   
>>    ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 201
>>    ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 217
>>    
>>
>
>These messages are perfectly normal.
>
>Apart from the messages, what is actually broken?  Is there a device
>that is not functional?  Which one?
>  
>
Hi Bjorn,

Okay I irgnored all the ACPI messages blowing ower my screen.
The NVidia PCIe 6600GT doesn't work, i tried it with an ATI PCIe X800pro
but the same result both
graphic adapters won't work. The Marvell sometimes not work after boot.
The driver sk98lin 8.16.2.3 loaded normally, but I can't get them up
with ifconfig.

Thanks for help and assistence
Greets Michael





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
