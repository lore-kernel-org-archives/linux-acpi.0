From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH 2/2] acpi: allow to add/remove multiple _OSI strings
Date: Thu, 09 Dec 2010 23:09:17 +0800
Message-ID: <1291907357.2181.4.camel@localhost>
References: <1291884666.10384.47.camel@minggr.sh.intel.com>
	 <AANLkTi=fw9Hoo6=hgu4_VndoDzd_T4Mq4bV9tVSvPLft@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3190 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab0LIPIv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 10:08:51 -0500
In-Reply-To: <AANLkTi=fw9Hoo6=hgu4_VndoDzd_T4Mq4bV9tVSvPLft@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2010-12-09 at 23:04 +0800, Lin Ming wrote:
> ---------- Forwarded message ----------
> From: Lin Ming <ming.m.lin@intel.com>
> Date: Thu, Dec 9, 2010 at 4:51 PM
> Subject: [PATCH 2/2] acpi: allow to add/remove multiple _OSI strings
> To: lenb <lenb@kernel.org>, Lukas Hejtmanek <xhejtman@ics.muni.cz>
> Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi
> <linux-acpi@vger.kernel.org>
> 
> 
> commit b0ed7a91(ACPICA/ACPI: Add new host interfaces for _OSI suppor)
> introduced another regression that only one _OSI string can be added or
> removed.
> 
> Now multiple _OSI strings can be added or removed, for example
> 
> acpi_osi=Linux acpi_osi=FreeBSD acpi_osi="!Windows 2006"
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/acpi/osl.c |   66 +++++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 50 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 6867443..d6e181a 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -110,9 +110,6 @@ struct acpi_ioremap {
>  static LIST_HEAD(acpi_ioremaps);
>  static DEFINE_SPINLOCK(acpi_ioremap_lock);
> 
> -#define        OSI_STRING_LENGTH_MAX 64        /* arbitrary */
> -static char osi_setup_string[OSI_STRING_LENGTH_MAX];
> -
>  static void __init acpi_osi_setup_late(void);
> 
>  /*
> @@ -1054,16 +1051,47 @@ static int __init acpi_os_name_setup(char *str)
> 
>  __setup("acpi_os_name=", acpi_os_name_setup);
> 
> +#define        OSI_STRING_LENGTH_MAX 64        /* arbitrary */
> +#define        OSI_STRING_ENTRIES_MAX 16       /* arbitrary */
> +
> +struct osi_setup_entry {
> +       char string[OSI_STRING_LENGTH_MAX];
> +       bool enable;
> +};
> +
> +static struct osi_setup_entry osi_setup_entries[OSI_STRING_ENTRIES_MAX];

Len,

A small update, mark osi_setup_entries as __initdata.
Would you consider merging this for 2.6.37-rc6?

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d6e181a..d0a1bb5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1059,7 +1059,7 @@ struct osi_setup_entry {
 	bool enable;
 };
 
-static struct osi_setup_entry osi_setup_entries[OSI_STRING_ENTRIES_MAX];
+static struct osi_setup_entry __initdata osi_setup_entries[OSI_STRING_ENTRIES_MAX];
 
 void __init acpi_osi_setup(char *str)
 {



