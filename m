From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
Date: 01 Dec 2004 00:41:49 -0500
Message-ID: <1101879708.8028.62.camel@d845pe>
References: <41990138.7080008@aknet.ru> <1101190148.19999.394.camel@d845pe>
	 <41A4CF1C.6090503@aknet.ru> <1101336267.20008.5326.camel@d845pe>
	 <41A621DD.8060102@aknet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5ycK+gAFzk7SRJ0mB3Gt"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41A621DD.8060102-D1TkPCJej5s@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stas Sergeev <stsp-D1TkPCJej5s@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-5ycK+gAFzk7SRJ0mB3Gt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for running the tests.
Please confirm that this patch make the problem go away in the 
CONFIG_PNP_ACPI=y configuration.

-Len


--=-5ycK+gAFzk7SRJ0mB3Gt
Content-Disposition: attachment; filename=pnp.patch
Content-Type: text/plain; name=pnp.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/pci_link.c 1.35 vs edited =====
--- 1.35/drivers/acpi/pci_link.c	2004-11-09 03:08:36 -05:00
+++ edited/drivers/acpi/pci_link.c	2004-12-01 00:38:18 -05:00
@@ -791,9 +791,16 @@
 	return 1;
 }
 
+/*
+ * We'd like PNP to call this routine for the
+ * single ISA_USED value for each legacy device.
+ * But instead it calls us with each POSSIBLE setting.
+ * There is no ISA_POSSIBLE weight, so we simply use
+ * the (small) PCI_USING penalty.
+ */
 void acpi_penalize_isa_irq(int irq)
 {
-	acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+	acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
 }
 
 /*

--=-5ycK+gAFzk7SRJ0mB3Gt--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
