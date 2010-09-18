From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v4] acpi: Handle ACPI0007 Device in acpi_early_set_pdc
Date: Fri, 17 Sep 2010 23:26:24 -0700
Message-ID: <4C945B90.5060306@kernel.org>
References: <4C89906B.1050406@kernel.org> <201009131128.42519.bjorn.helgaas@hp.com> <4C931714.2080905@kernel.org> <201009170756.53100.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:55207 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0IRG1i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Sep 2010 02:27:38 -0400
In-Reply-To: <201009170756.53100.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Suresh Siddha <suresh.b.siddha@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>


After
| commit d8191fa4a33fdc817277da4f2b7f771ff605a41c
| Author: Alex Chiang <achiang@hp.com>
| Date:   Mon Feb 22 12:11:39 2010 -0700
|
|    ACPI: processor: driver doesn't need to evaluate _PDC
|
|    Now that the early _PDC evaluation path knows how to correctly
|    evaluate _PDC on only physically present processors, there's no
|    need for the processor driver to evaluate it later when it loads.
|
|    To cover the hotplug case, push _PDC evaluation down into the
|    hotplug paths.

only cpu with Processor Statement get processed with _PDC

If bios is using Device object instead of Processor statement.
SSDTs for Pstate/Cstate/Tstate can not be loaded dynamically.

Need to try to scan ACPI0007 in addition to Processor.

That commit is between 2.6.34-rc1 and 2.6.34-rc2, so stable tree for 2.6.34+
need this patch.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/acpi/processor_core.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -352,4 +352,5 @@ void __init acpi_early_processor_set_pdc
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    early_init_pdc, NULL, NULL, NULL);
+	acpi_get_devices("ACPI0007", early_init_pdc, NULL, NULL);
 }
