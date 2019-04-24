From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 30/63] Documentation: PCI: convert acpi-info.txt to
 reST
Date: Wed, 24 Apr 2019 12:34:25 -0300
Message-ID: <20190424123425.3e63f970@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-31-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-31-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:59 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/{acpi-info.txt =3D> acpi-info.rst} | 11 ++++++++---
>  Documentation/PCI/index.rst                        |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
>  rename Documentation/PCI/{acpi-info.txt =3D> acpi-info.rst} (97%)
>=20
> diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-inf=
o.rst
> similarity index 97%
> rename from Documentation/PCI/acpi-info.txt
> rename to Documentation/PCI/acpi-info.rst
> index 3ffa3b03970e..f7dabb7ca255 100644
> --- a/Documentation/PCI/acpi-info.txt
> +++ b/Documentation/PCI/acpi-info.rst
> @@ -1,4 +1,8 @@
> -		ACPI considerations for PCI host bridges
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ACPI considerations for PCI host bridges
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The general rule is that the ACPI namespace should describe everything t=
he
>  OS might use unless there's another way for the OS to find it [1, 2].
> @@ -135,8 +139,9 @@ address always corresponds to bus 0, even if the bus =
range below the bridge
> =20
>      Extended Address Space Descriptor (.4)
>      General Flags: Bit [0] Consumer/Producer:
> -	1=E2=80=93This device consumes this resource
> -	0=E2=80=93This device produces and consumes this resource
> +
> +        * 1 =E2=80=93 This device consumes this resource
> +        * 0 =E2=80=93 This device produces and consumes this resource

Hmm.. I think that you would need to add some extra blank lines before
the above, e. g., something like:

	[4] ACPI 6.2, sec 6.4.3.5.1, 2, 3, 4:
	    QWord/DWord/Word Address Space Descriptor (.1, .2, .3)
	      General Flags: Bit [0] Ignored
=09
	    Extended Address Space Descriptor (.4)
	      General Flags: Bit [0] Consumer/Producer:

		* 1 =E2=80=93 This device consumes this resource
		* 0 =E2=80=93 This device produces and consumes this resource

> =20
>  [5] ACPI 6.2, sec 19.6.43:
>      ResourceUsage specifies whether the Memory range is consumed by
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 1b25bcc1edca..c877a369481d 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -12,3 +12,4 @@ Linux PCI Bus Subsystem
>     PCIEBUS-HOWTO
>     pci-iov-howto
>     MSI-HOWTO
> +   acpi-info



Thanks,
Mauro
