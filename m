From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v5.1 13/13] ACPI / DSD: Document references, ports and endpoints
Date: Thu, 23 Mar 2017 16:12:31 +0200
Message-ID: <1490278351-12229-1-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-14-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489667481-28521-14-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Document the use of references into the hierarchical data extension
structure, as well as the use of port and endpoint concepts that are very
similar to those in Devicetree.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
since v5:

- Clarify port and endpoint node object naming. Using both port and endpoint
  cleanly resolves object naming by using the appropriate port and
  endpoint numbers.

- Endpoint node numbers are unique within a port, not an endpoint.

The diff between v5 is below.

 diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/acpi/dsd/graph.txt
 new file mode 100644
-index 0000000..064fa8a
+index 0000000..ac09e31
 --- /dev/null
 +++ b/Documentation/acpi/dsd/graph.txt
-@@ -0,0 +1,160 @@
+@@ -0,0 +1,162 @@
 +Graphs
 +
 +
@@ -61,21 +60,23 @@
 +All port nodes are located under the device's "_DSD" node in the
 +hierarchical data extension tree. The property extension related to
 +each port node must contain the key "port" and an integer value which
-+is the number of the port.
++is the number of the port. The object it refers to should be called "PRTX",
++where "X" is the number of the port.
 +
 +Further on, endpoints are located under the individual port nodes. The
 +first hierarchical data extension package list entry of the endpoint
 +nodes must begin with "endpoint" and must be followed by the number
-+of the endpoint.
++of the endpoint. The object it refers to should be called "EPXY", where
++"X" is the number of the port and "Y" is the number of the endpoint.
 +
 +Each port node contains a property extension key "port", the value of
 +which is the number of the port node. The each endpoint is similarly numbered
 +with a property extension key "endpoint". Port numbers must be unique within a
-+device and endpoint numbers must be unique within an endpoint.
++device and endpoint numbers must be unique within a port.
 +
 +The endpoint reference uses property extension with "remote-endpoint" property
 +name followed by a reference in the same package. Such references consist of the
-+name of the remote device, number of the port in the device and finally the
++the remote device reference, number of the port in the device and finally the
 +number of the endpoint in that port. Individual references thus appear as:
 +
 +    Package() { device, port_number, endpoint_number }
@@ -106,10 +107,10 @@
 +		},
 +		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 +		Package () {
-+		    Package () { "endpoint0", "EP0" },
++		    Package () { "endpoint0", "EP00" },
 +		}
 +	    })
-+	    Name (EP0, Package() {
++	    Name (EP00, Package() {
 +		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 +		Package () {
 +		    Package () { "endpoint", 0 },
@@ -137,11 +138,11 @@
 +		},
 +		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 +		Package () {
-+		    Package () { "endpoint0", "EP0" },
++		    Package () { "endpoint0", "EP40" },
 +		}
 +	    })
 +
-+	    Name (EP0, Package() {
++	    Name (EP40, Package() {
 +		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 +		Package () {
 +		    Package () { "endpoint", 0 },

 Documentation/acpi/dsd/graph.txt | 162 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/acpi/dsd/graph.txt

diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/acpi/dsd/graph.txt
new file mode 100644
index 0000000..ac09e31
--- /dev/null
+++ b/Documentation/acpi/dsd/graph.txt
@@ -0,0 +1,162 @@
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
+is the number of the port. The object it refers to should be called "PRTX",
+where "X" is the number of the port.
+
+Further on, endpoints are located under the individual port nodes. The
+first hierarchical data extension package list entry of the endpoint
+nodes must begin with "endpoint" and must be followed by the number
+of the endpoint. The object it refers to should be called "EPXY", where
+"X" is the number of the port and "Y" is the number of the endpoint.
+
+Each port node contains a property extension key "port", the value of
+which is the number of the port node. The each endpoint is similarly numbered
+with a property extension key "endpoint". Port numbers must be unique within a
+device and endpoint numbers must be unique within a port.
+
+The endpoint reference uses property extension with "remote-endpoint" property
+name followed by a reference in the same package. Such references consist of the
+the remote device reference, number of the port in the device and finally the
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
+		    Package () { "endpoint0", "EP00" },
+		}
+	    })
+	    Name (EP00, Package() {
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
+		    Package () { "endpoint0", "EP40" },
+		}
+	    })
+
+	    Name (EP40, Package() {
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
