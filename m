From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/3] usb: typec: mux: Use the "compatible" property instead of a boolean property
Date: Wed, 27 Mar 2019 19:43:39 +0300
Message-ID: <20190327164339.31205-4-heikki.krogerus@linux.intel.com>
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Biju Das <biju.das@bp.renesas.com>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Instead of searching for a boolean property, matching
against the "compatible" property.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 2ce54f3fc79c..9462b90f1c09 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -32,11 +32,7 @@ static void *typec_switch_match(struct device_connection *con, int ep,
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	/*
-	 * With OF graph the mux node must have a boolean device property named
-	 * "orientation-switch".
-	 */
-	if (con->id && !fwnode_property_present(con->fwnode, con->id))
+	if (con->id && !fwnode_is_compatible(con->fwnode, con->id))
 		return NULL;
 
 	list_for_each_entry(sw, &switch_list, entry)
@@ -148,7 +144,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 
 	/* Accessory Mode muxes */
 	if (!desc) {
-		match = fwnode_property_present(con->fwnode, "accessory");
+		match = fwnode_is_compatible(con->fwnode, "accessory");
 		if (match)
 			goto find_mux;
 		return NULL;
-- 
2.20.1
