From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Date: Fri, 14 Dec 2018 23:22:36 +0100
Message-ID: <20181214222236.GK11710@zn.tnic>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
 <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Cc: linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 14, 2018 at 10:27:25PM +0100, Thomas Schoebel-Theuer wrote:
> please take a look at the stacktrace. For some reason, and only at that
> specific hardware, the condition is false, there but later the indicated
> error exit is taken whose message you can see immediately before the stack
> trace.

Yes, but if you say "for some reason", then we still don't know what
the root cause is. So before we do any fixing, let's find out what the
problem is first.

Can you pls run this debugging hunk ontop of -rc6, on the box and send
me full dmesg? Privately is fine too.

Thx.

---
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 7389db538c30..5166639b7280 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -667,6 +667,9 @@ void __init pci_mmcfg_early_init(void)
 			acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
 		__pci_mmcfg_init(1);
 
+		pr_info("%s: setting apei filter\n", __func__);
+		dump_stack();
+
 		set_apei_filter();
 	}
 }
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index da370e1d31f4..e87b183ca73d 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -494,6 +494,9 @@ int apei_resources_request(struct apei_resources *resources,
 	if (rc)
 		goto nvs_res_fini;
 
+	pr_info("%s: 1, arch_apei_filter_addr: 0x%px\n",
+		__func__, arch_apei_filter_addr);
+
 	if (arch_apei_filter_addr) {
 		apei_resources_init(&arch_res);
 		rc = apei_get_arch_resources(&arch_res);
@@ -552,6 +555,9 @@ int apei_resources_request(struct apei_resources *resources,
 		release_mem_region(res->start, res->end - res->start);
 	}
 arch_res_fini:
+	pr_info("%s: arch_res_fini, arch_apei_filter_addr: 0x%px\n",
+		__func__, arch_apei_filter_addr);
+
 	if (arch_apei_filter_addr)
 		apei_resources_fini(&arch_res);
 nvs_res_fini:

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
