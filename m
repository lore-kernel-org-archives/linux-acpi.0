From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v3 06/13] ACPI / property: Don't limit named child node matching to data nodes
Date: Fri, 12 Apr 2019 16:41:15 +0300
Message-ID: <20190412134122.82903-7-heikki.krogerus@linux.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There is no reason why we should limit the use of
fwnode_get_named_child_node() to data nodes only.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 77abe0ec4043..572a6868ff2e 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -602,15 +602,29 @@ static struct fwnode_handle *
 acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 				 const char *childname)
 {
+	char name[ACPI_PATH_SEGMENT_LENGTH];
 	struct fwnode_handle *child;
+	struct acpi_buffer path;
+	acpi_status status;
 
-	/*
-	 * Find first matching named child node of this fwnode.
-	 * For ACPI this will be a data only sub-node.
-	 */
-	fwnode_for_each_child_node(fwnode, child)
-		if (acpi_data_node_match(child, childname))
+	path.length = sizeof(name);
+	path.pointer = name;
+
+	fwnode_for_each_child_node(fwnode, child) {
+		if (is_acpi_data_node(child)) {
+			if (acpi_data_node_match(child, childname))
+				return child;
+			continue;
+		}
+
+		status = acpi_get_name(ACPI_HANDLE_FWNODE(child),
+				       ACPI_SINGLE_NAME, &path);
+		if (ACPI_FAILURE(status))
+			break;
+
+		if (!strncmp(name, childname, ACPI_NAMESEG_SIZE))
 			return child;
+	}
 
 	return NULL;
 }
-- 
2.20.1
