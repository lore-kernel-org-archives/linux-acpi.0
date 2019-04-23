From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 14/63] Documentation: ACPI: move dsd/graph.txt to
 firmware-guide/acpi and convert to reST
Date: Tue, 23 Apr 2019 18:14:50 -0300
Message-ID: <20190423181450.3120530d@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-15-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-15-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:43 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/dsd/graph.rst}                       | 157 +++++++++---------
>  Documentation/firmware-guide/acpi/index.rst   |   1 +
>  2 files changed, 81 insertions(+), 77 deletions(-)
>  rename Documentation/{acpi/dsd/graph.txt =3D> firmware-guide/acpi/dsd/gr=
aph.rst} (56%)
>=20
> diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/firmware-gu=
ide/acpi/dsd/graph.rst
> similarity index 56%
> rename from Documentation/acpi/dsd/graph.txt
> rename to Documentation/firmware-guide/acpi/dsd/graph.rst
> index b9ce910781dc..e0baed35b037 100644
> --- a/Documentation/acpi/dsd/graph.txt
> +++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
> @@ -1,8 +1,11 @@
> -Graphs
> +.. SPDX-License-Identifier: GPL-2.0
> =20
> +=3D=3D=3D=3D=3D=3D
> +Graphs
> +=3D=3D=3D=3D=3D=3D
> =20
>  _DSD
> -----
> +=3D=3D=3D=3D
> =20
>  _DSD (Device Specific Data) [7] is a predefined ACPI device
>  configuration object that can be used to convey information on
> @@ -30,7 +33,7 @@ hierarchical data extension array on each depth.
> =20
> =20
>  Ports and endpoints
> --------------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The port and endpoint concepts are very similar to those in Devicetree
>  [3]. A port represents an interface in a device, and an endpoint
> @@ -38,9 +41,9 @@ represents a connection to that interface.
> =20
>  All port nodes are located under the device's "_DSD" node in the hierarc=
hical
>  data extension tree. The data extension related to each port node must b=
egin
> -with "port" and must be followed by the "@" character and the number of =
the port
> -as its key. The target object it refers to should be called "PRTX", wher=
e "X" is
> -the number of the port. An example of such a package would be:
> +with "port" and must be followed by the "@" character and the number of =
the
> +port as its key. The target object it refers to should be called "PRTX",=
 where
> +"X" is the number of the port. An example of such a package would be::
> =20
>      Package() { "port@4", PRT4 }
> =20
> @@ -49,7 +52,7 @@ data extension key of the endpoint nodes must begin with
>  "endpoint" and must be followed by the "@" character and the number of t=
he
>  endpoint. The object it refers to should be called "EPXY", where "X" is =
the
>  number of the port and "Y" is the number of the endpoint. An example of =
such a
> -package would be:
> +package would be::
> =20
>      Package() { "endpoint@0", EP40 }
> =20
> @@ -62,85 +65,85 @@ of that port shall be zero. Similarly, if a port may =
only have a single
>  endpoint, the number of that endpoint shall be zero.
> =20
>  The endpoint reference uses property extension with "remote-endpoint" pr=
operty
> -name followed by a reference in the same package. Such references consis=
t of the
> +name followed by a reference in the same package. Such references consis=
t of
>  the remote device reference, the first package entry of the port data ex=
tension
>  reference under the device and finally the first package entry of the en=
dpoint
> -data extension reference under the port. Individual references thus appe=
ar as:
> +data extension reference under the port. Individual references thus appe=
ar as::
> =20
>      Package() { device, "port@X", "endpoint@Y" }
> =20
> -In the above example, "X" is the number of the port and "Y" is the numbe=
r of the
> -endpoint.
> +In the above example, "X" is the number of the port and "Y" is the numbe=
r of
> +the endpoint.
> =20
>  The references to endpoints must be always done both ways, to the
>  remote endpoint and back from the referred remote endpoint node.
> =20
> -A simple example of this is show below:
> +A simple example of this is show below::
> =20
>      Scope (\_SB.PCI0.I2C2)
>      {
> -	Device (CAM0)
> -	{
> -	    Name (_DSD, Package () {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "compatible", Package () { "nokia,smia" } },
> -		},
> -		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> -		Package () {
> -		    Package () { "port@0", PRT0 },
> -		}
> -	    })
> -	    Name (PRT0, Package() {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "reg", 0 },
> -		},
> -		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> -		Package () {
> -		    Package () { "endpoint@0", EP00 },
> -		}
> -	    })
> -	    Name (EP00, Package() {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "reg", 0 },
> -		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4=
", "endpoint@0" } },
> -		}
> -	    })
> -	}
> +        Device (CAM0)
> +        {
> +            Name (_DSD, Package () {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "compatible", Package () { "nokia,smia"=
 } },
> +                },
> +                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +                Package () {
> +                    Package () { "port@0", PRT0 },
> +                }
> +            })
> +            Name (PRT0, Package() {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "reg", 0 },
> +                },
> +                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +                Package () {
> +                    Package () { "endpoint@0", EP00 },
> +                }
> +            })
> +            Name (EP00, Package() {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "reg", 0 },
> +                    Package () { "remote-endpoint", Package() { \_SB.PCI=
0.ISP, "port@4", "endpoint@0" } },
> +                }
> +            })
> +        }
>      }
> =20
>      Scope (\_SB.PCI0)
>      {
> -	Device (ISP)
> -	{
> -	    Name (_DSD, Package () {
> -		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> -		Package () {
> -		    Package () { "port@4", PRT4 },
> -		}
> -	    })
> -
> -	    Name (PRT4, Package() {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "reg", 4 }, /* CSI-2 port number */
> -		},
> -		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> -		Package () {
> -		    Package () { "endpoint@0", EP40 },
> -		}
> -	    })
> -
> -	    Name (EP40, Package() {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "reg", 0 },
> -		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, =
"port@0", "endpoint@0" } },
> -		}
> -	    })
> -	}
> +        Device (ISP)
> +        {
> +            Name (_DSD, Package () {
> +                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +                Package () {
> +                    Package () { "port@4", PRT4 },
> +                }
> +            })
> +
> +            Name (PRT4, Package() {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "reg", 4 }, /* CSI-2 port number */
> +                },
> +                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +                Package () {
> +                    Package () { "endpoint@0", EP40 },
> +                }
> +            })
> +
> +            Name (EP40, Package() {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "reg", 0 },
> +                    Package () { "remote-endpoint", Package () { \_SB.PC=
I0.I2C2.CAM0, "port@0", "endpoint@0" } },
> +                }
> +            })
> +        }
>      }
> =20
>  Here, the port 0 of the "CAM0" device is connected to the port 4 of
> @@ -148,27 +151,27 @@ the "ISP" device and vice versa.
> =20
> =20
>  References
> -----------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  [1] _DSD (Device Specific Data) Implementation Guide.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-implemen=
tation-guide-toplevel-1_1.htm>,
> +    http://www.uefi.org/sites/default/files/resources/_DSD-implementatio=
n-guide-toplevel-1_1.htm,
>      referenced 2016-10-03.
> =20
> -[2] Devicetree. <URL:http://www.devicetree.org>, referenced 2016-10-03.
> +[2] Devicetree. http://www.devicetree.org, referenced 2016-10-03.
> =20
>  [3]=C2=A0Documentation/devicetree/bindings/graph.txt
> =20
>  [4] Device Properties UUID For _DSD.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-p=
roperties-UUID.pdf>,
> +    http://www.uefi.org/sites/default/files/resources/_DSD-device-proper=
ties-UUID.pdf,
>      referenced 2016-10-04.
> =20
>  [5] Hierarchical Data Extension UUID For _DSD.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarch=
ical-data-extension-UUID-v1.1.pdf>,
> +    http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-=
data-extension-UUID-v1.1.pdf,
>      referenced 2016-10-04.
> =20
>  [6] Advanced Configuration and Power Interface Specification.
> -    <URL:http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf>,
> +    http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
>      referenced 2016-10-04.
> =20
>  [7] _DSD Device Properties Usage Rules.
> -    Documentation/acpi/DSD-properties-rules.txt
> +    :doc:`../DSD-properties-rules`
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/=
firmware-guide/acpi/index.rst
> index bedcb0b242a2..f81cfbcb6878 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -8,6 +8,7 @@ ACPI Support
>     :maxdepth: 1
> =20
>     namespace
> +   dsd/graph
>     enumeration
>     osi
>     method-customizing



Thanks,
Mauro
