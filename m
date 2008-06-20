From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 25/70] ACPICA: Update disassembler for DMAR table changes
Date: Fri, 20 Jun 2008 21:49:32 +0200
Message-ID: <87hcbnanub.fsf@basil.nowhere.org>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
	<ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out01.alice-dsl.net ([88.44.60.11]:4740 "EHLO
	smtp-out01.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYFTTuL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 15:50:11 -0400
In-Reply-To: <ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com> (Len Brown's message of "Fri, 20 Jun 2008 03:43:27 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

Len Brown <lenb@kernel.org> writes:

> From: Bob Moore <robert.moore@intel.com>
>
> Now supports the 2007 intel Virtualization Technology for Directed
> I/O specification.

This patch does nothing? It just adds declarations and unused symbols

-Andi

>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  include/acpi/acdisasm.h |    1 +
>  include/acpi/actbl1.h   |    4 ++++
>  2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
> index 788f887..f53faca 100644
> --- a/include/acpi/acdisasm.h
> +++ b/include/acpi/acdisasm.h
> @@ -162,6 +162,7 @@ extern struct acpi_dmtable_info acpi_dm_table_info_dmar_hdr[];
>  extern struct acpi_dmtable_info acpi_dm_table_info_dmar_scope[];
>  extern struct acpi_dmtable_info acpi_dm_table_info_dmar0[];
>  extern struct acpi_dmtable_info acpi_dm_table_info_dmar1[];
> +extern struct acpi_dmtable_info acpi_dm_table_info_dmar2[];
>  extern struct acpi_dmtable_info acpi_dm_table_info_ecdt[];
>  extern struct acpi_dmtable_info acpi_dm_table_info_einj[];
>  extern struct acpi_dmtable_info acpi_dm_table_info_einj0[];
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 715a489..bc47ce5 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -311,6 +311,10 @@ struct acpi_table_dmar {
>  	u8 reserved[10];
>  };
>  
> +/* Flags */
> +
> +#define ACPI_DMAR_INTR_REMAP        (1)
> +
>  /* DMAR subtable header */
>  
>  struct acpi_dmar_header {
> -- 
> 1.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
