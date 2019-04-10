From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 01/12] software node: Allow node creation without properties
Date: Wed, 10 Apr 2019 18:24:54 +0300
Message-ID: <20190410152505.87041-2-heikki.krogerus@linux.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Software nodes are not forced to have device properties.
Adding check to property_entries_dup() to make it possible
to create software nodes that don't have any properties.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 7fc5a18e02ad..30077454eb68 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -383,6 +383,9 @@ property_entries_dup(const struct property_entry *properties)
 	int i, n = 0;
 	int ret;
 
+	if (!properties)
+		return NULL;
+
 	while (properties[n].name)
 		n++;
 
-- 
2.20.1
