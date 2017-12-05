From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V6 4/7] OF: properties: Implement get_match_data() callback
Date: Tue,  5 Dec 2017 12:04:49 -0500
Message-ID: <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Now that we have a get_match_data() callback as part of the firmware node,
implement the OF specific piece for it.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/of/property.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 264c355..9964169 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -981,6 +981,12 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
+			       struct device *dev)
+{
+	return (void *)of_device_get_match_data(dev);
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -996,5 +1002,6 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
 	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
+	.get_match_data = of_fwnode_get_match_data,
 };
 EXPORT_SYMBOL_GPL(of_fwnode_ops);
-- 
1.9.1
