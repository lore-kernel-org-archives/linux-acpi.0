From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 13/13] ACPI / DSD: Document references, ports and endpoints
Date: Thu, 16 Mar 2017 14:31:21 +0200
Message-ID: <1489667481-28521-14-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11924 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdCPMc4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 08:32:56 -0400
In-Reply-To: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Document the use of references into the hierarchical data extension
structure, as well as the use of port and endpoint concepts that are very
similar to those in Devicetree.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/acpi/dsd/graph.txt | 160 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/acpi/dsd/graph.txt

diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/acpi/dsd/graph.txt
new file mode 100644
index 0000000..064fa8a
--- /dev/null
+++ b/Documentation/acpi/dsd/graph.txt
@@ -0,0 +1,160 @@
+Graphs
+
+
+_DSD
+----
+
+_DSD (Device Specific Data) [7] is a predefined ACPI device
+configuration object that can be used to convey information on
+hardware features which are not specifically covered by the ACPI
+specification [1][6]. There are two _DSD extensions that are relevant
+for graphs: property [4] and hierarchical data extensions [5]. The
+property extension provides generic key-value pairs whereas the
+hierarchical data extension supports nodes with references to other
+nodes, forming a tree. The nodes in the tree may contain properties as
+defined by the property extension. The two extensions together provide
+a tree-like structure with zero or more properties (key-value pairs)
+in each node of the tree.
+
+The data structure may be accessed at runtime by using the device_*
+and fwnode_* functions defined in include/linux/fwnode.h .
+
+Fwnode represents a generic firmware node object. It is independent on
+the firmware type. In ACPI, fwnodes are _DSD hierarchical data
+extensions objects. A device's _DSD object is represented by an
+fwnode.
+
+The data structure may be referenced to elsewhere in the ACPI tables
+by using a hard reference to the device itself and an index to the
+hierarchical data extension array on each depth.
+
+
+Ports and endpoints
+-------------------
+
+The port and endpoint concepts are very similar to those in Devicetree
+[3]. A port represents an interface in a device, and an endpoint
+represents a connection to that interface.
+
+All port nodes are located under the device's "_DSD" node in the
+hierarchical data extension tree. The property extension related to
+each port node must contain the key "port" and an integer value which
+is the number of the port.
+
+Further on, endpoints are located under the individual port nodes. The
+first hierarchical data extension package list entry of the endpoint
+nodes must begin with "endpoint" and must be followed by the number
+of the endpoint.
+
+Each port node contains a property extension key "port", the value of
+which is the number of the port node. The each endpoint is similarly numbered
+with a property extension key "endpoint". Port numbers must be unique within a
+device and endpoint numbers must be unique within an endpoint.
+
+The endpoint reference uses property extension with "remote-endpoint" property
+name followed by a reference in the same package. Such references consist of the
+name of the remote device, number of the port in the device and finally the
+number of the endpoint in that port. Individual references thus appear as:
+
+    Package() { device, port_number, endpoint_number }
+
+The references to endpoints must be always done both ways, to the
+remote endpoint and back from the referred remote endpoint node.
+
+A simple example of this is show below:
+
+    Scope (\_SB.PCI0.I2C2)
+    {
+	Device (CAM0)
+	{
+	    Name (_DSD, Package () {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "compatible", Package () { "nokia,smia" } },
+		},
+		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		Package () {
+		    Package () { "port0", "PRT0" },
+		}
+	    })
+	    Name (PRT0, Package() {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "port", 0 },
+		},
+		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		Package () {
+		    Package () { "endpoint0", "EP0" },
+		}
+	    })
+	    Name (EP0, Package() {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "endpoint", 0 },
+		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, 4, 0 } },
+		}
+	    })
+	}
+    }
+
+    Scope (\_SB.PCI0)
+    {
+	Device (ISP)
+	{
+	    Name (_DSD, Package () {
+		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		Package () {
+		    Package () { "port4", "PRT4" },
+		}
+	    })
+
+	    Name (PRT4, Package() {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "port", 4 }, /* CSI-2 port number */
+		},
+		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		Package () {
+		    Package () { "endpoint0", "EP0" },
+		}
+	    })
+
+	    Name (EP0, Package() {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "endpoint", 0 },
+		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, 0, 0 } },
+		}
+	    })
+	}
+    }
+
+Here, the port 0 of the "CAM0" device is connected to the port 4 of
+the "ISP" device and vice versa.
+
+
+References
+----------
+
+[1] _DSD (Device Specific Data) Implementation Guide.
+    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm>,
+    referenced 2016-10-03.
+
+[2] Devicetree. <URL:http://www.devicetree.org>, referenced 2016-10-03.
+
+[3] Documentation/devicetree/bindings/graph.txt
+
+[4] Device Properties UUID For _DSD.
+    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+    referenced 2016-10-04.
+
+[5] Hierarchical Data Extension UUID For _DSD.
+    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf>,
+    referenced 2016-10-04.
+
+[6] Advanced Configuration and Power Interface Specification.
+    <URL:http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf>,
+    referenced 2016-10-04.
+
+[7] _DSD Device Properties Usage Rules.
+    Documentation/acpi/DSD-properties-rules.txt
-- 
2.7.4

