From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 05/22] ACPI: add acpi_dev_get_device()
Date: Tue, 28 Jul 2015 15:19:36 +0200
Message-ID: <1438089593-7696-6-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

This function is just a getter for struct acpi_device.dev and is needed
in the implementation of the fwnode API when building with !CONFIG_ACPI.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Add acpi_dev_get_device()

 include/linux/acpi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 01e6770d8e27..d1ad6c20c7e4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -78,6 +78,11 @@ static inline void acpi_preset_companion(struct device *dev,
 	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, NULL));
 }
 
+static inline struct device *acpi_dev_get_device(struct acpi_device *adev)
+{
+	return &adev->dev;
+}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return dev_name(&adev->dev);
@@ -476,6 +481,11 @@ static inline bool has_acpi_companion(struct device *dev)
 	return false;
 }
 
+static inline struct device *acpi_dev_get_device(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return NULL;
-- 
2.4.3
