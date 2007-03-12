From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 2/2] ACPI: parse 2nd MADT by default
Date: Sun, 11 Mar 2007 18:28:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0703111828250.7793@shark.he.net>
References: <11736626612135-git-send-email-lenb@kernel.org>
 <11736626621682-git-send-email-lenb@kernel.org> <1173662663486-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:43539 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932498AbXCLB2r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Mar 2007 21:28:47 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sun, 11 Mar 2007 17:28:45 -0800
In-Reply-To: <1173662663486-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sun, 11 Mar 2007, Len Brown wrote:

> From: Len Brown <len.brown@intel.com>
>
> http://bugzilla.kernel.org/show_bug.cgi?id=7465
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  Documentation/kernel-parameters.txt |    2 +-
>  drivers/acpi/tables.c               |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 22c6b8c..f0b7a5e 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -142,7 +142,7 @@ and is between 256 and 4096 characters. It is defined in the file
>  			Format: <int>
>  			2: use 2nd APIC table, if available
>  			1,0: use 1st APIC table
> -			default: 0
> +			default: 2
>
>  	acpi_sleep=	[HW,ACPI] Sleep options
>  			Format: { s3_bios, s3_mode }
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index c341918..6d5515a 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -42,7 +42,7 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
>
>  static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
>
> -static int acpi_apic_instance __initdata;
> +static int acpi_apic_instance = 2; __initdata;

extra semi-colon ;

>
>  void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  {
>

-- 
~Randy
