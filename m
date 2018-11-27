From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v4 4/4] driver core: Add fwnode member to struct device_connection
Date: Tue, 27 Nov 2018 17:28:55 +0300
Message-ID: <20181127142855.73899-5-heikki.krogerus@linux.intel.com>
References: <20181127142855.73899-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127142855.73899-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This will prepare the device connection API for connections
described in firmware.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..25e0409e0b0c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -757,11 +757,17 @@ struct device_dma_parameters {
 
 /**
  * struct device_connection - Device Connection Descriptor
+ * @fwnode: The device node of the connected device
  * @endpoint: The names of the two devices connected together
  * @id: Unique identifier for the connection
  * @list: List head, private, for internal use only
+ *
+ * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
+ * platform firmware defines the connection. When the connection is registeded
+ * with device_connection_add() @endpoint is used instead.
  */
 struct device_connection {
+	struct fwnode_handle	*fwnode;
 	const char		*endpoint[2];
 	const char		*id;
 	struct list_head	list;
-- 
2.19.2
