From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 03/22] device property: add fwnode_get_name()
Date: Tue, 28 Jul 2015 15:19:34 +0200
Message-ID: <1438089593-7696-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Getting a textual representation of a device node can be very useful for
debugging.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Use of_node_full_name()

 drivers/base/property.c  | 15 +++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f3f6d167f3f1..efa74803af30 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -533,3 +533,18 @@ bool device_dma_is_coherent(struct device *dev)
 	return coherent;
 }
 EXPORT_SYMBOL_GPL(device_dma_is_coherent);
+
+/**
+ * fwnode_get_name - return the name of a device node
+ * @fwnode: Device node to find the name of
+ */
+const char *fwnode_get_name(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		return of_node_full_name(to_of_node(fwnode));
+	else if (is_acpi_node(fwnode))
+		return acpi_dev_name(to_acpi_node(fwnode));
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_name);
diff --git a/include/linux/property.h b/include/linux/property.h
index 76ebde9c11d4..826f156f7288 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -63,6 +63,8 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
+const char *fwnode_get_name(struct fwnode_handle *fwnode);
+
 #define device_for_each_child_node(dev, child) \
 	for (child = device_get_next_child_node(dev, NULL); child; \
 	     child = device_get_next_child_node(dev, child))
-- 
2.4.3
