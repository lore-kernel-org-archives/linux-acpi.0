From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
Date: Wed, 01 Dec 2004 21:26:19 +0100
Message-ID: <41AE28EB.9090302@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 >+/*
 >+ * We'd like PNP to call this routine for the
 >+ * single ISA_USED value for each legacy device.
 >+ * But instead it calls us with each POSSIBLE setting.
 >+ * There is no ISA_POSSIBLE weight, so we simply use
 >+ * the (small) PCI_USING penalty.
 >+ */

Couldn't be better to change the pnp core behaviour ?

In drivers/pnp/resource.c, pnp_register_irq_resource, instead of calling 
pcibios_penalize_isa_irq couldn't we call something like 
pcibios_penalize_possible_isa_irq ?

The pnp implemations already use pcibios_penalize_isa_irq [1] for the 
irq that are used.
So it seem it is call 2 times for the allocated resources...
Also don't we need to depenalize the irq, if we change the irq or 
disable the device ?

Matthieu CASTET


[1]
$grep -r penalize */*
pnpacpi/rsparser.c: 
pcibios_penalize_isa_irq(res->data.irq.interrupts[0]);
pnpacpi/rsparser.c: 
pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0]);
pnpbios/rsparser.c:             pcibios_penalize_isa_irq(irq);


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
