From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v6 6/6] ACPI: Set hotplug _OST support bit to _OSC
Date: Tue, 26 Jun 2012 14:42:54 -0600
Message-ID: <1340743374-18535-7-git-send-email-toshi.kani@hp.com>
References: <1340743374-18535-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340743374-18535-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: bhelgaas@google.com, shuahkhan@gmail.com, liuj97@gmail.com, andi@firstfloor.org, isimatu.yasuaki@jp.fujitsu.com, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

When ACPI_HOTPLUG_OST is defined, set hotplug _OST support bit
OSC_SB_HOTPLUG_OST_SUPPORT to indicate that the OS supports hotplug
_OST by calling the platform-wide ACPI Operating System Capabilities
(_OSC).

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/bus.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index adceafd..9628652 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -574,6 +574,10 @@ static void acpi_bus_osc_support(void)
 	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PPC_OST_SUPPORT;
 #endif
 
+#ifdef ACPI_HOTPLUG_OST
+	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_HOTPLUG_OST_SUPPORT;
+#endif
+
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
-- 
1.7.7.6
