From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 22/63] Documentation: ACPI: move lpit.txt to
 firmware-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 11:49:30 -0300
Message-ID: <20190424114930.09df0827@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-23-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-23-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:51 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/firmware-guide/acpi/index.rst    |  1 +
>  .../lpit.txt =3D> firmware-guide/acpi/lpit.rst}  | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>  rename Documentation/{acpi/lpit.txt =3D> firmware-guide/acpi/lpit.rst} (=
68%)
>=20
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/=
firmware-guide/acpi/index.rst
> index fca854f017d8..0e60f4b7129a 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -22,3 +22,4 @@ ACPI Support
>     gpio-properties
>     i2c-muxes
>     acpi-lid
> +   lpit
> diff --git a/Documentation/acpi/lpit.txt b/Documentation/firmware-guide/a=
cpi/lpit.rst
> similarity index 68%
> rename from Documentation/acpi/lpit.txt
> rename to Documentation/firmware-guide/acpi/lpit.rst
> index b426398d2e97..aca928fab027 100644
> --- a/Documentation/acpi/lpit.txt
> +++ b/Documentation/firmware-guide/acpi/lpit.rst
> @@ -1,3 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Low Power Idle Table (LPIT)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
>  To enumerate platform Low Power Idle states, Intel platforms are using
>  =E2=80=9CLow Power Idle Table=E2=80=9D (LPIT). More details about this t=
able can be
>  downloaded from:
> @@ -8,13 +14,15 @@ Residencies for each low power state can be read via F=
FH
> =20
>  On platforms supporting S0ix sleep states, there can be two types of
>  residencies:
> -- CPU PKG C10 (Read via FFH interface)
> -- Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
> +
> +  - CPU PKG C10 (Read via FFH interface)
> +  - Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interfa=
ce)
> =20
>  The following attributes are added dynamically to the cpuidle
> -sysfs attribute group:
> -	/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> -	/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> +sysfs attribute group::
> +
> +  /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> +  /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> =20
>  The "low_power_idle_cpu_residency_us" attribute shows time spent
>  by the CPU package in PKG C10



Thanks,
Mauro
