From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v5 20/23] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 15:12:36 -0300
Message-ID: <20190424151236.776d9678@coco.lan>
References: <20190424175306.25880-1-changbin.du@gmail.com>
        <20190424175306.25880-21-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424175306.25880-21-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Thu, 25 Apr 2019 01:53:03 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
>  Documentation/admin-guide/acpi/index.rst      |  1 +
>  2 files changed, 40 insertions(+), 32 deletions(-)
>  rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
> 
> diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> similarity index 51%
> rename from Documentation/acpi/cppc_sysfs.txt
> rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
> index f20fb445135d..a4b99afbe331 100644
> --- a/Documentation/acpi/cppc_sysfs.txt
> +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> @@ -1,5 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  
> -	Collaborative Processor Performance Control (CPPC)
> +==================================================
> +Collaborative Processor Performance Control (CPPC)
> +==================================================
> +
> +CPPC
> +====
>  
>  CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
>  performance of a logical processor on a contigious and abstract performance
> @@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
>  
>  http://uefi.org/specifications
>  
> -Some of the CPPC registers are exposed via sysfs under:
> -
> -/sys/devices/system/cpu/cpuX/acpi_cppc/


> -
> -for each cpu X

Yeah, there it is: you're removing those two lines.

> +Some of the CPPC registers are exposed via sysfs under::
>  
> ---------------------------------------------------------------------------------
> +  /sys/devices/system/cpu/cpuX/acpi_cppc/

As per my reply to v4.

Thanks,
Mauro
