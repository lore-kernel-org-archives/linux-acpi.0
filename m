From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: Acpi irq handler doesn't detect ICH4 sound device with
 ALSA. Is a known bug?
Date: Fri, 13 Aug 2004 15:25:09 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <411D1595.7090706@optonline.net>
References: <20040813211607.0e8bce72@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040813211607.0e8bce72@debian>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Pere_Casta=F1er?= <XaRz69-pCzzcW6XgXY@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pere Castañer wrote:
> Hi,
> 
> I upgraded my kernel from 2.6.5 to 2.6.7  and then with 2.6.8rc3 with acpi patch from 15th of July. With all these kernels the latest acpi code has problems to detect my onboard pci soundcard which uses snd-intel8x0m module (ICH4).
> When I try to load it manually I receive this message:
> 
> -----------------------------------------------------------------
> ACPI: PCI interrupt 0000:00.1f.5[B] GSI 7 (level,low)----> IRQ7
> Intel ICH probe of 0000:00:1f.5 failed with error -16
> unable to grab IRQ7
> ----------------------------------------------------------------
> 
> I suspect that ACPI has problems to handle the IRQ's at boot time. When I append to boot loader the string pci=noacpi the pci IRQ handler detects my soundcard nicely.

Does "acpi=irq" also work? That is a little less aggressive about what 
it disables...

> 
> PS:Is a Dell Inspiron 8500.
> 
> PSS:Tested with kernel 2.6.8rc3 patched with acpi20040715-2.6.8rc2 patch.
> 



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
