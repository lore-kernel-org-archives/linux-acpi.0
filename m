From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH v3 3/3] ACPI: 80 column adherence and spelling fix (no
	functional change)
Date: Tue, 04 Nov 2008 14:53:05 -0700
Message-ID: <20081104215305.15214.41345.stgit@bob.kio>
References: <20081104213732.15214.174.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:26911 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146AbYKDVxG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Nov 2008 16:53:06 -0500
In-Reply-To: <20081104213732.15214.174.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/acpi/processor_core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index bc332fc..b57b1f0 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -595,9 +595,10 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		}
 
 		/*
-		* TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
-		*      >>> 'acpi_get_processor_id(acpi_id, &id)' in arch/xxx/acpi.c
-		*/
+		 * TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
+		 *      >>> 'acpi_get_processor_id(acpi_id, &id)' in
+		 *      arch/xxx/acpi.c
+		 */
 		pr->acpi_id = object.processor.proc_id;
 	}
 	cpu_index = get_cpu_id(pr->handle, device_declaration, pr->acpi_id);

