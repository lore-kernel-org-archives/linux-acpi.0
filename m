From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 3/3] x86/xen: supply rsdp address in boot params for pvh guests
Date: Thu,  7 Dec 2017 13:28:21 +0100
Message-ID: <20171207122821.30158-4-jgross@suse.com>
References: <20171207122821.30158-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207122821.30158-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>
List-Id: linux-acpi@vger.kernel.org

When booted via the special PVH entry save the RSDP address set in the
boot information block in struct boot_params. This will enable Xen to
locate the RSDP at an arbitrary address.

Set the boot loader version to 2.14 (0x020e) replacing the wrong 0x0212
which should have been 0x020c.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2: set bootloader version to 2.14 (Roger Pau Monné)
---
 arch/x86/xen/enlighten_pvh.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 436c4f003e17..036e3a5f284a 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -68,9 +68,12 @@ static void __init init_pvh_bootparams(void)
 	 *
 	 * Version 2.12 supports Xen entry point but we will use default x86/PC
 	 * environment (i.e. hardware_subarch 0).
+	 * The RSDP address is available from version 2.14 on.
 	 */
-	pvh_bootparams.hdr.version = 0x212;
+	pvh_bootparams.hdr.version = 0x20e;
 	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
+
+	pvh_bootparams.hdr.acpi_rsdp_addr = pvh_start_info.rsdp_paddr;
 }
 
 /*
-- 
2.12.3
