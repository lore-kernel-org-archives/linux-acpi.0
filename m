From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/5] acpi : move the acpi_idle_driver variable declaration
Date: Wed, 25 Jul 2012 12:45:58 +0200
Message-ID: <1343213162-8064-2-git-send-email-daniel.lezcano@linaro.org>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1343213162-8064-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This variable is only used in the in processor_driver.c.
This patch reduces the scope of the variable by moving it
to this file.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/acpi/processor_driver.c |    2 +-
 include/acpi/processor.h        |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 7048b97..017b39d 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -113,7 +113,7 @@ static struct acpi_driver acpi_processor_driver = {
 
 DEFINE_PER_CPU(struct acpi_processor *, processors);
 EXPORT_PER_CPU_SYMBOL(processors);
-
+extern struct cpuidle_driver acpi_idle_driver;
 struct acpi_processor_errata errata __read_mostly;
 
 /* --------------------------------------------------------------------------
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index db427fa..8b2c39a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -332,7 +332,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device);
 int acpi_processor_suspend(struct device *dev);
 int acpi_processor_resume(struct device *dev);
-extern struct cpuidle_driver acpi_idle_driver;
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
-- 
1.7.5.4
