From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 21/22] driver core: Start processing deferred probes earlier
Date: Mon,  7 Sep 2015 14:23:46 +0200
Message-ID: <1441628627-5143-22-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37312 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbbIGMYq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2015 08:24:46 -0400
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Some initcalls in the late level assume that some devices will have
already probed without explicitly checking for that.

After the recent move to defer most device probes when they are
registered, pressure increased in the late initcall level.

By starting the processing of the deferred queue in device_initcall_sync
we increase the chances that the initcalls mentioned before will find
the devices they depend on to have already probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v4:
- Start processing deferred probes in device_initcall_sync

Changes in v3: None
Changes in v2: None

 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0654fb771a53..b6a22cff78cf 100644
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

