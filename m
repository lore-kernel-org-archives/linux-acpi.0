From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 5/9] ACPI: move acpi_os_handler() so
 it can be made arch-dependent later
Date: Wed, 25 Feb 2015 21:47:02 +0800
Message-ID: <54EDD256.1010009@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org> <1424824585-6405-6-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424824585-6405-6-git-send-email-al.stone@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: al.stone@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robert.moore@intel.com, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B402=E6=9C=8825=E6=97=A5 08:36, al.stone@linaro.org wrote=
:
> From: Al Stone <al.stone@linaro.org>
>
> In order to deprecate the use of _OSI for arm64 or other new architec=
tures,
> we need to make the default handler something we can change for vario=
us
> platforms.  This patch moves the definition of acpi_osi_handler() -- =
the
> function used by ACPICA as a callback for evaluating _OSI -- into a s=
eparate
> file.  Subsequent patches will change which files get built so that w=
e can
> then build the version of _OSI we need for a particular architecture.
>
> There is no functional change.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>   drivers/acpi/Makefile |  2 +-
>   drivers/acpi/osi.c    | 95 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>   drivers/acpi/osl.c    | 24 -------------
>   include/linux/acpi.h  |  1 +
>   4 files changed, 97 insertions(+), 25 deletions(-)
>   create mode 100644 drivers/acpi/osi.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 13536d8..97191eb 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -18,7 +18,7 @@ obj-y				+=3D acpi.o \
>   					acpica/
>
>   # All the builtin files are in the "acpi." module_param namespace.
> -acpi-y				+=3D osl.o utils.o reboot.o
> +acpi-y				+=3D osl.o utils.o reboot.o osi.o
>   acpi-y				+=3D nvs.o
>
>   # Power management related files
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> new file mode 100644
> index 0000000..f23aa70
> --- /dev/null
> +++ b/drivers/acpi/osi.c
> @@ -0,0 +1,95 @@
> +/*
> + *  osi.c - _OSI implementation (moved from drivers/acpi/osl.c)
> + *
> + *  Copyright (C) 2000       Andrew Henroid
> + *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
> + *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@in=
tel.com>
> + *  Copyright (c) 2008 Intel Corporation
> + *   Author: Matthew Wilcox <willy@linux.intel.com>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or mo=
dify
> + *  it under the terms of the GNU General Public License as publishe=
d by
> + *  the Free Software Foundation; either version 2 of the License, o=
r
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> + *
> + */
> +
> +#include <linux/acpi.h>
> +
> +#define _COMPONENT		ACPI_OS_SERVICES
> +ACPI_MODULE_NAME("osi");
> +
> +#define PREFIX			"ACPI: "

Hi Al, remove PREFIX here and use pr_fmt() instead as
I mentioned in previous patch :)

Thanks
Hanjun
