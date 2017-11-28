From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 3/3] x86/xen: supply rsdp address in boot params for pvh guests
Date: Tue, 28 Nov 2017 10:44:00 +0100
Message-ID: <20171128094400.25955-4-jgross@suse.com>
References: <20171128094400.25955-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128094400.25955-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>
List-Id: linux-acpi@vger.kernel.org

When booted via the special PVH entry save the RSDP address set in the
boot information block in struct boot_params. This will enable Xen to
locate the RSDP at an arbitrary address.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pvh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 436c4f003e17..0175194f4236 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -71,6 +71,8 @@ static void __init init_pvh_bootparams(void)
 	 */
 	pvh_bootparams.hdr.version = 0x212;
 	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
+
+	pvh_bootparams.hdr.acpi_rsdp_addr = pvh_start_info.rsdp_paddr;
 }
 
 /*
-- 
2.12.3
