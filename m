From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v3 07/13] device connection: Find connections also by checking the references
Date: Fri, 12 Apr 2019 16:41:16 +0300
Message-ID: <20190412134122.82903-8-heikki.krogerus@linux.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We can also use this API to find named references that the
device nodes have by using fwnode_property_get_reference_args()
function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae235e4..4cdf95532b63 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -38,6 +38,30 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static void *
+fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+		    void *data, devcon_match_fn_t match)
+{
+	struct device_connection con = { };
+	struct fwnode_reference_args args;
+	void *ret;
+	int i;
+
+	for (i = 0; ; i++) {
+		if (fwnode_property_get_reference_args(fwnode, con_id, NULL, 0,
+						       i, &args))
+			break;
+
+		con.fwnode = args.fwnode;
+		ret = match(&con, -1, data);
+		fwnode_handle_put(args.fwnode);
+		if (ret)
+			return ret;
+	}
+
+	return NULL;
+}
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -65,6 +89,10 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
 		if (ret)
 			return ret;
+
+		ret = fwnode_devcon_match(fwnode, con_id, data, match);
+		if (ret)
+			return ret;
 	}
 
 	mutex_lock(&devcon_lock);
-- 
2.20.1
