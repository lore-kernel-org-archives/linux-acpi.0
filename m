From: Max Asbock <masbock@linux.vnet.ibm.com>
Subject: Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode
 is set in HEST for corrected machine checks
Date: Tue, 07 May 2013 08:40:14 -0700
Message-ID: <1367941214.4518.90.camel@oc3432500282.ibm.com>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
	 <20130506232537.GF22041@pd.tnic>
	 <1367897566.4518.83.camel@oc3432500282.ibm.com>
	 <20130507131946.GC7633@pd.tnic>
Reply-To: masbock@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:44753 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756874Ab3EGPmg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 11:42:36 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <masbock@linux.vnet.ibm.com>;
	Tue, 7 May 2013 11:42:32 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C738B38C825C
	for <linux-acpi@vger.kernel.org>; Tue,  7 May 2013 11:40:45 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r47FeJcL287190
	for <linux-acpi@vger.kernel.org>; Tue, 7 May 2013 11:40:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r47FeIPK003791
	for <linux-acpi@vger.kernel.org>; Tue, 7 May 2013 11:40:18 -0400
In-Reply-To: <20130507131946.GC7633@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, ying.huang@intel.com, naveen.n.rao@in.ibm.com, ananth@in.ibm.com, lcm@linux.vnet.ibm.com

On Tue, 2013-05-07 at 15:19 +0200, Borislav Petkov wrote:
> On Mon, May 06, 2013 at 08:32:46PM -0700, Max Asbock wrote:
> > But this is glue code between MCE and APEI, therefore I thought a
> > file named mce-apei.c would be a good place. If we put it into apei
> > then we might have to export some of the MCE interfaces, whereas
> > apei_hest_parse() is already exported.
> 
> Right, I don't want to expose any MCA internals to other subsystems
> unless it is really necessary.
> 
> AFAICT, you need an ON and OFF switch for CMCI which is callable from
> outside. So you can adapt/adjust the code in mce_intel.c to do so
> without adding any other code.
> 
> Unless I'm missing something. But I don't think so, the high-level
> sequence looks like this:
> 
> * MCA init
>  -> CMCI init
> * APEI init:
>  -> if FF
>     -> CMCI off
> 
> At a quick glance, simply doing:
> 
> 	on_each_cpu(cmci_clear_func, NULL, 1);
> 
> should work. You'd need to define a proper cmci_clear_func prototype but
> that should be trivial...
> 

So something like the following patch might be closer:


Signed-off-by: Max Asbock <masbock@linux.vnet.ibm.com>
---
 mce-apei.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff -burpN linux-3.9/arch/x86/kernel/cpu/mcheck/mce-apei.c linux-3.9.ff2/arch/x86/kernel/cpu/mcheck/mce-apei.c
--- linux-3.9/arch/x86/kernel/cpu/mcheck/mce-apei.c	2013-05-02 09:38:16.000000000 -0700
+++ linux-3.9.ff2/arch/x86/kernel/cpu/mcheck/mce-apei.c	2013-05-07 08:12:16.000000000 -0700
@@ -32,6 +32,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/cper.h>
+#include <linux/init.h>
 #include <acpi/apei.h>
 #include <asm/mce.h>
 
@@ -148,3 +149,54 @@ int apei_clear_mce(u64 record_id)
 {
 	return erst_clear(record_id);
 }
+
+
+/* Support for Firmware First (FF) mode for Corrected Machine Checks
+ * as defined by APEI in the Hardware Error Source Table (HEST).
+ * (see section 18.3.2.2 in the ACPI spec, version 5.0)
+ *
+ * When Firmware First mode is specified in HEST for Corrected Machine Checks,
+ * these errors are expected to be reported by the firmware through a
+ * Generic Harware Event Source (GHES). In this case error reporting
+ * through CMCI should not be enabled so it won't interfere with the firmware.
+ *
+ * In the boot sequence HEST parsing is initialized after
+ * CPUs, therefore initially we don't know if Firmware First is set.
+ * We enable CMCI at first and then disable it in a late init call if FF is set.
+ */
+
+static bool cmc_firmware_first;
+
+static int check_cmc_firmware_first(struct acpi_hest_header *hest_hdr, void *d)
+{
+	if (hest_hdr->type == ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) {
+		struct acpi_hest_ia_corrected *cmc;
+
+		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
+		if (cmc->flags & ACPI_HEST_FIRMWARE_FIRST) {
+			cmc_firmware_first = true;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void disable_cmci(void *data)
+{
+	if (!mce_available(__this_cpu_ptr(&cpu_info)))
+		return;
+	cmci_clear();
+}
+
+static __init int honor_cmc_firmware_first(void)
+{
+	apei_hest_parse(check_cmc_firmware_first, NULL);
+
+	if (cmc_firmware_first && !mca_cfg.cmci_disabled) {
+		on_each_cpu(disable_cmci, NULL, 1);
+		mca_cfg.cmci_disabled = true;
+	}
+	return 0;
+}
+
+late_initcall(honor_cmc_firmware_first);


