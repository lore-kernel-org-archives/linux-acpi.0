From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v5 22/23] driver core: Start processing deferred probes earlier
Date: Thu, 17 Sep 2015 14:57:16 +0200
Message-ID: <1442494637-3674-23-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-acpi@vger.kernel.org

Some initcalls in the late level assume that some devices will have
already probed without explicitly checking for that.

After the recent move to defer most device probes when they are
registered, pressure increased in the late initcall level.

By starting the processing of the deferred queue in device_initcall_sync
we increase the chances that the initcalls mentioned before will find
the devices they depend on to have already probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5: None
Changes in v4:
- Start processing deferred probes in device_initcall_sync

Changes in v3: None
Changes in v2: None

 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 300c59562fc9..5d8572be9b63 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -176,7 +176,7 @@ static void driver_deferred_probe_trigger(void)
  *
  * We don't want to get in the way when the bulk of drivers are getting probed.
  * Instead, this initcall makes sure that deferred probing is delayed until
- * late_initcall time.
+ * device_initcall_sync time.
  */
 static int deferred_probe_initcall(void)
 {
@@ -190,7 +190,7 @@ static int deferred_probe_initcall(void)
 	flush_workqueue(deferred_wq);
 	return 0;
 }
-late_initcall(deferred_probe_initcall);
+device_initcall_sync(deferred_probe_initcall);
 
 static void driver_bound(struct device *dev)
 {
-- 
2.4.3
