From: Feng Kan <fkan@apm.com>
Subject: [PATCH V2 6/6] acpi: platform: add ACPI code for X-Gene reboot
 platform driver.
Date: Tue,  7 Jan 2014 14:50:41 -0800
Message-ID: <1389135041-16062-7-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389135041-16062-1-git-send-email-fkan@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-acpi@vger.kernel.org

Add ACPI code for X-Gene reboot platform driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/acpi/acpi_platform.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index dbfe49e..9fe1d4f 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -37,6 +37,9 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "INT33C8" },
 	{ "80860F28" },
 
+	/* APM X-Gene */
+	{ "APMC0D08" },
+
 	{ }
 };
 
-- 
1.7.6.1
