From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 16/16] ACPI / DSD: Document references, ports and endpoints
Date: Mon, 13 Mar 2017 23:08:29 +0100
Message-ID: <1629581.fh46rNHz4U@aspire.rjw.lan>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com> <1488809970-25568-17-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49527 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752553AbdCMWNy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Mar 2017 18:13:54 -0400
In-Reply-To: <1488809970-25568-17-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Monday, March 06, 2017 04:19:30 PM Sakari Ailus wrote:
> Document the use of references into the hierarchical data extension
> structure, as well as the use of port and endpoint concepts that are very
> similar to those in Devicetree.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/acpi/dsd/graph.txt | 164 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/acpi/dsd/graph.txt
> 
> diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/acpi/dsd/graph.txt
> new file mode 100644
> index 0000000..6195936
> --- /dev/null
> +++ b/Documentation/acpi/dsd/graph.txt
> @@ -0,0 +1,164 @@
> +Graphs
> +
> +
> +_DSD
> +----
> +
> +_DSD (Device Specific Data) [7] is a predefined ACPI device
> +configuration object that can be used to convey information on
> +hardware features which are not specifically covered by the ACPI
> +specification [1][6]. There are two _DSD extensions that are relevant
> +for graphs: property [4] and hierarchical data extensions [5]. The
> +property extension provides generic key-value pairs whereas the
> +hierarchical data extension supports nodes with references to other
> +nodes, forming a tree. The nodes in the tree may contain properties as
> +defined by the property extension. The two extensions together provide
> +a tree-like structure with zero or more properties (key-value pairs)
> +in each node of the tree.
> +
> +The data structure may be accessed at runtime by using the device_*
> +and fwnode_* functions defined in include/linux/fwnode.h .
> +
> +Fwnode represents a generic firmware node object. It is independent on
> +the firmware type. In ACPI, fwnodes are _DSD hierarchical data
> +extensions objects. A device's _DSD object is represented by an
> +fwnode.
> +
> +The data structure may be referenced to elsewhere in the ACPI tables
> +by using a hard reference to the device itself and an index to the
> +hierarchical data extension array on each depth.
> +
> +
> +Ports and endpoints
> +-------------------
> +
> +The port and endpoint concepts are very similar to those in Devicetree
> +[3]. The port represent represent interface in a device, and an

s/represent represent/represents/

Plus I would say "a port" and "an interface".

> +endpoint represents a connection to that interface.
> +
> +All port nodes are located under the device's "_DSD" node in
> +hierarchical data extension tree. The first package list entry of the
> +hierarchical data extension related to each port node must begin with
> +"port" string and must be followed by the number of the port.

So "port" should be the key, right?

> +
> +Further on, endpoints are located under the individual port nodes. The
> +first hierarchical data extension package list entry of the endpoint
> +nodes must begin with "endpoint" and must be followed by the number
> +of the endpoint.
> +
> +Each port node contains a property extension key "port", the value of
> +which is the number of the port node. The number of the endpoint node is
> +the index of the endpoint node in the endpoint node array under the port
> +node, starting from 0.
> +
> +The endpoint reference uses property extension with "remote-endpoint"
> +property name followed by a reference in the same package. Such references
> +consist of the name of the device, index of the port node and finally the
> +index of the endpoint node. The port index is indeed index to the referred
> +port array, not the number of the port that is related to numbering of
> +actual hardware interfaces in the respective hardware. The endpoint nodes
> +are always referred to using an index to the endpoint node array.
> +Individual references thus appear as:
> +
> +    Package() { device, port_node_index, endpoint_node_index }
> +
> +The references to endpoints must be always done both ways, to the
> +remote endpoint and back from the referred remote endpoint node.
> +
> +A simple example of this is show below:
> +
> +    Scope (\_SB.PCI0.I2C2)
> +    {
> +	Device (CAM0)
> +	{
> +	    Name (_DSD, Package () {
> +		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +		Package () {
> +		    Package () { "compatible", Package () { "nokia,smia" } },
> +		},
> +		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +		Package () {
> +		    Package () { "port0", "PRT0" },
> +		}
> +	    })
> +	    Name (PRT0, Package() {
> +		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +		Package () {
> +		    Package () { "port", 0 },
> +		},
> +		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +		Package () {
> +		    Package () { "endpoint0", "EP0" },
> +		}
> +	    })
> +	    Name (EP0, Package() {
> +		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +		Package () {
> +		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, 0, 0 } },
> +		}
> +	    })
> +	}
> +    }
> +
> +    Scope (\_SB.PCI0)
> +    {
> +	Device (ISP)
> +	{
> +	    Name (_DSD, Package () {
> +		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +		Package () {
> +		    Package () { "port4", "PRT4" },
> +		}
> +	    })
> +
> +	    Name (PRT4, Package() {
> +		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +		Package () {
> +		    Package () { "port", 4 }, /* CSI-2 port number */
> +		},
> +		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +		Package () {
> +		    Package () { "endpoint0", "EP0" },
> +		}
> +	    })
> +
> +	    Name (EP0, Package() {
> +		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +		Package () {
> +		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, 0, 0 } },

Why indices and not the keys?  Something like

	Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port0", "endpoint0" } },

should work too and would be more flexible I suppose and less prone to errors.

> +		}
> +	    })
> +	}
> +    }
> +
> +Here, the port 0 of the "CAM0" device is connected to the port 4 of
> +the "ISP" device. Note that the port index in the reference is still
> +0, as it refers to an entry in the table and not the port node number
> +itself.

Thanks,
Rafael

