From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] Add Intel Poulsbo Stub Driver
Date: Wed, 1 Sep 2010 10:11:18 -0700
Message-ID: <20100901101118.1d3784bf.randy.dunlap@oracle.com>
References: <1283332119-26352-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:53557 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab0IARMt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Sep 2010 13:12:49 -0400
In-Reply-To: <1283332119-26352-1-git-send-email-jlee@novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, mjg@redhat.com, gregkh@suse.de, jlee@novell.com, Dennis.Jansen@web.de, linux-acpi@vger.kernel.org, trenn@suse.de

On Wed,  1 Sep 2010 17:08:39 +0800 Lee, Chun-Yi wrote:

> Currently, there have no Poulsbo native video driver to support
> intel opregion. So, use this stub driver to enable the acpi backlight
> control sysfs entry files by requrest acpi_video_register.
> 
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> ---
>  drivers/gpu/Makefile       |    2 +-
>  drivers/gpu/stub/Kconfig   |   13 +++++++++
>  drivers/gpu/stub/Makefile  |    1 +
>  drivers/gpu/stub/poulsbo.c |   64 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/video/Kconfig      |    2 +
>  5 files changed, 81 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/gpu/stub/Kconfig
>  create mode 100644 drivers/gpu/stub/Makefile
>  create mode 100644 drivers/gpu/stub/poulsbo.c
> 
> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index 30879df..cc92778 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
> @@ -1 +1 @@
> -obj-y			+= drm/ vga/
> +obj-y			+= drm/ vga/ stub/
> diff --git a/drivers/gpu/stub/Kconfig b/drivers/gpu/stub/Kconfig
> new file mode 100644
> index 0000000..c564140
> --- /dev/null
> +++ b/drivers/gpu/stub/Kconfig
> @@ -0,0 +1,13 @@
> +config STUB_POULSBO
> +	tristate "Intel Poulsbo Stub Driver"
> +        default m

Drop the "default m".

> +        # Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
> +        # but for select to work, need to select ACPI_VIDEO's dependencies, ick
> +        select ACPI_VIDEO if ACPI

What does it do when ACPI is not enabled?  Does the driver even build
when APCI is not enabled?  (given the acpi_video* calls in it)

It also has pci_* calls in it, so it looks like it needs to depend
on PCI && ACPI, or at least on PCI.



> +	help
> +	  Choose this option if you have a system that has Intel Poulsbo
> +	  integrated graphics. If M is selected, the module will be called
> +	  Poulsbo. This driver is a stub driver for Poulsbo that will call
> +	  poulsbo.ko to enable the acpi backlight control sysfs entry file
> +	  because there have no poulsbo native driver can support intel
> +	  opregion.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
