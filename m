From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI / LPSS: Force lpss quirks on boot
Date: Tue, 04 Sep 2018 15:17:45 +0800
Message-ID: <1536045465.2282.21.camel@intel.com>
References: <20180901175916.28567-1-william.lieurance@namikoda.com>
         <1535942331.2072.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535942331.2072.5.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Lieurance <william.lieurance@namikoda.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 一, 2018-09-03 at 10:38 +0800, Zhang Rui wrote:
> Hi, William,
> 
> On 六, 2018-09-01 at 12:59 -0500, William Lieurance wrote:
> > 
> > For some number of systems with lpss_quirks enabled, on boot the
> > system
> > goes through an acpi_lpss_resume() without a corresponding
> > acpi_lpss_suspend() having been called.
> I read the code but didn't find out why this could happen, but if it
> is
> true, please check if the below patch helps
> 
> From 27fda1ab0d800966b0ec1c444fe356812bd2f04e Mon Sep 17 00:00:00
> 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Mon, 3 Sep 2018 10:00:07 +0800
> Subject: [PATCH] ACPI / LPSS: Force lpss quirks on boot
> 
> Commit 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and
> resume
> from hibernation") bypasses lpss quirks for S3 and S4, by setting a
> flag
> for S3/S4 in acpi_lpss_suspend(), and check that flag in
> acpi_lpss_resume().
> 
> But this overlooks the boot case where acpi_lpss_resume() may get
> called
> without a corresponding acpi_lpss_suspend() having been called.
> 
> Thus force setting the flag during boot.
> 
> Fixes: 12864ff8545f (ACPI / LPSS: Avoid PM quirks on suspend and
> resume from hibernation)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200989
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

According to https://bugzilla.kernel.org/show_bug.cgi?id=200989#c6,
the patch has been confirmed to fix the problem.
Don't know why the patch does not show up in patchwork.
Let me resend.

>From f07303f10e41c2b61d0d4da5f74e98a3bf8e7147 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 3 Sep 2018 10:00:07 +0800
Subject: [PATCH] ACPI / LPSS: Force lpss quirks on boot

Commit 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and resume
from hibernation") bypasses lpss quirks for S3 and S4, by setting a flag
for S3/S4 in acpi_lpss_suspend(), and check that flag in
acpi_lpss_resume().

But this overlooks the boot case where acpi_lpss_resume() may get called
without a corresponding acpi_lpss_suspend() having been called.

Thus force setting the flag during boot.

Fixes: 12864ff8545f (ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200989
Reported-and-tested-by: William Lieurance <william.lieurance@namikoda.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 9706613..bf64cfa 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -879,7 +879,7 @@ static void acpi_lpss_dismiss(struct device *dev)
 #define LPSS_GPIODEF0_DMA_LLP		BIT(13)
 
 static DEFINE_MUTEX(lpss_iosf_mutex);
-static bool lpss_iosf_d3_entered;
+static bool lpss_iosf_d3_entered = true;
 
 static void lpss_iosf_enter_d3_state(void)
 {
-- 
2.7.4
