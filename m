From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ACPI: Export interfaces for ioremapping/iounmapping ACPI registers
Date: Sun, 6 Nov 2011 13:49:31 +0100
Message-ID: <201111061349.31311.rjw@sisk.pl>
References: <20110929215907.21126.24480.stgit@amt.stowe> <20110929215913.21126.71203.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52931 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab1KFMqy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Nov 2011 07:46:54 -0500
In-Reply-To: <20110929215913.21126.71203.stgit@amt.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com, bhelgaas@google.com

On Thursday, September 29, 2011, Myron Stowe wrote:
> From: Myron Stowe <mstowe@redhat.com>
> 
> Export remapping and unmapping interfaces - acpi_os_map_generic_address()
> and acpi_os_unmap_generic_address() - for ACPI generic registers
> that are backed by memory mapped I/O (MMIO).
> 
> ACPI Generic Address Structure (GAS) reference (ACPI's fixed/generic
> hardware registers use the GAS format):
>   ACPI Specification, Revision 4.0, Section 5.2.3.1, "Generic Address
>   Structure"
> 
> Signed_off_by: Myron Stowe <myron.stowe@redhat.com>

Nothing wrong with that in principle.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
> 
>  drivers/acpi/osl.c      |    6 ++++--
>  include/linux/acpi_io.h |    3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index fa32f58..46c5c18 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -426,7 +426,7 @@ void __init early_acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
>  		__acpi_unmap_table(virt, size);
>  }
>  
> -static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
> +int acpi_os_map_generic_address(struct acpi_generic_address *addr)
>  {
>  	void __iomem *virt;
>  
> @@ -442,8 +442,9 @@ static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(acpi_os_map_generic_address);
>  
> -static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
> +void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
>  {
>  	struct acpi_ioremap *map;
>  
> @@ -464,6 +465,7 @@ static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
>  
>  	acpi_os_map_cleanup(map);
>  }
> +EXPORT_SYMBOL_GPL(acpi_os_unmap_generic_address);
>  
>  #ifdef ACPI_FUTURE_USAGE
>  acpi_status
> diff --git a/include/linux/acpi_io.h b/include/linux/acpi_io.h
> index 4afd710..b0ffa21 100644
> --- a/include/linux/acpi_io.h
> +++ b/include/linux/acpi_io.h
> @@ -12,4 +12,7 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  
>  void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
>  
> +int acpi_os_map_generic_address(struct acpi_generic_address *addr);
> +void acpi_os_unmap_generic_address(struct acpi_generic_address *addr);
> +
>  #endif
> 
> 
> 

