From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 11/63] Documentation: ACPI: move dsdt-override.txt to
 admin-guide/acpi and convert to reST
Date: Tue, 23 Apr 2019 18:08:45 -0300
Message-ID: <20190423180845.603542d5@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-12-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-12-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:40 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/dsdt-override.rst}                               | 8 +++++++-
>  Documentation/admin-guide/acpi/index.rst                  | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
>  rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)
> 
> diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/admin-guide/acpi/dsdt-override.rst
> similarity index 56%
> rename from Documentation/acpi/dsdt-override.txt
> rename to Documentation/admin-guide/acpi/dsdt-override.rst
> index 784841caa6e6..50bd7f194bf4 100644
> --- a/Documentation/acpi/dsdt-override.txt
> +++ b/Documentation/admin-guide/acpi/dsdt-override.rst
> @@ -1,6 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +Overriding DSDT
> +===============
> +
>  Linux supports a method of overriding the BIOS DSDT:
>  
> -CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
> +CONFIG_ACPI_CUSTOM_DSDT - builds the image into the kernel.
>  
>  When to use this method is described in detail on the
>  Linux/ACPI home page:
> diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> index 09e4e81e4fb7..d68e9914c5ff 100644
> --- a/Documentation/admin-guide/acpi/index.rst
> +++ b/Documentation/admin-guide/acpi/index.rst
> @@ -9,3 +9,4 @@ the Linux ACPI support.
>     :maxdepth: 1
>  
>     initrd_table_override
> +   dsdt-override



Thanks,
Mauro
