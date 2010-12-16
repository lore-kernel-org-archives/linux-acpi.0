From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/9] Revert "x86: allocate space within a region top-down"
Date: Thu, 16 Dec 2010 10:38:25 -0700
Message-ID: <20101216173825.8185.75773.stgit@bob.kio>
References: <20101216173614.8185.19462.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101216173614.8185.19462.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org


This reverts commit 1af3c2e45e7a641e774bbb84fa428f2f0bf2d9c9.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 arch/x86/kernel/setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 21c6746..85268f8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -769,7 +769,6 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.oem.arch_setup();
 
-	resource_alloc_from_bottom = 0;
 	iomem_resource.end = (1ULL << boot_cpu_data.x86_phys_bits) - 1;
 	setup_memory_map();
 	parse_setup_data();
