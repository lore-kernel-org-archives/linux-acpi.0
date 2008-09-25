From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 2/7] acpi: remove have_arch_parse_srat in acpi.h
Date: Thu, 25 Sep 2008 09:01:08 -0600
Message-ID: <200809250901.09212.bjorn.helgaas@hp.com>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com> <1222308277-10984-2-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756176AbYIYPBl@vger.kernel.org>
In-Reply-To: <1222308277-10984-2-git-send-email-yhlu.kernel@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 24 September 2008 08:04:32 pm Yinghai Lu wrote:
> 32bit don't need that anymore

I don't understand the connection between this commit log and
the patch below.

> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> ---
>  include/linux/acpi.h |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4d5ec43..8eefaa9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -95,18 +95,10 @@ int acpi_parse_mcfg (struct acpi_table_header *header);
>  void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
>  
>  /* the following four functions are architecture-dependent */
> -#ifdef CONFIG_HAVE_ARCH_PARSE_SRAT
> -#define NR_NODE_MEMBLKS MAX_NUMNODES
> -#define acpi_numa_slit_init(slit) do {} while (0)
> -#define acpi_numa_processor_affinity_init(pa) do {} while (0)
> -#define acpi_numa_memory_affinity_init(ma) do {} while (0)
> -#define acpi_numa_arch_fixup() do {} while (0)
> -#else
>  void acpi_numa_slit_init (struct acpi_table_slit *slit);
>  void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
>  void acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
>  void acpi_numa_arch_fixup(void);
> -#endif
>  
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  /* Arch dependent functions for cpu hotplug support */
