From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/8] ACPI, APEI, CPER: Add UEFI 2.4 support for memory
 error
Date: Tue, 15 Oct 2013 22:56:25 +0530
Message-ID: <20131015172625.GB2777@naverao1-tp.ibm.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-6-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:58059 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759521Ab3JOR0r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 13:26:47 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 15 Oct 2013 22:56:45 +0530
Content-Disposition: inline
In-Reply-To: <1381473166-29303-6-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 2013/10/11 02:32AM, Chen Gong wrote:
> In latest UEFI spec(by now it is 2.4) memory error definition
> for CPER (UEFI 2.4 Appendix N Common Platform Error Record)
> adds some new fields. These fields help people to locate
> memory error on actual DIMM location.
> 
> Original-author: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/apei/cper.c | 3 ++-
>  include/linux/cper.h     | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
> index b2e4134..680230c 100644
> --- a/drivers/acpi/apei/cper.c
> +++ b/drivers/acpi/apei/cper.c
> @@ -8,7 +8,7 @@
>   * various tables, such as ERST, BERT and HEST etc.
>   *
>   * For more information about CPER, please refer to Appendix N of UEFI
> - * Specification version 2.3.
> + * Specification version 2.4.
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License version
> @@ -191,6 +191,7 @@ static const char *cper_mem_err_type_strs[] = {
>  	"memory sparing",
>  	"scrub corrected error",
>  	"scrub uncorrected error",
> +	"Physical Memory Map-out event",

All small letters to match the rest of the items:
"physical memory map-out event"

>  };
>  
>  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index c230494..bd01c9a 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -232,6 +232,9 @@ enum {
>  #define CPER_MEM_VALID_RESPONDER_ID		0x1000
>  #define CPER_MEM_VALID_TARGET_ID		0x2000
>  #define CPER_MEM_VALID_ERROR_TYPE		0x4000
> +#define CPER_MEM_VALID_RANK_NUMBER		0x8000
> +#define CPER_MEM_VALID_CARD_HANDLE		0x10000
> +#define CPER_MEM_VALID_MODULE_HANDLE		0x20000
>  
>  #define CPER_PCIE_VALID_PORT_TYPE		0x0001
>  #define CPER_PCIE_VALID_VERSION			0x0002
> @@ -347,6 +350,10 @@ struct cper_sec_mem_err {
>  	__u64	responder_id;
>  	__u64	target_id;
>  	__u8	error_type;
> +	__u8	reserved;
> +	__u16	rank;
> +	__u16	mem_array_handle;
> +	__u16	mem_dev_handle;

Nit: could you name those fields similar to what the spec has:
card_handle and module_handle, with perhaps a comment to indicate
relationship to SMBIOS type 16/17 tables?


Regards,
Naveen

>  };
>  
>  struct cper_sec_pcie {
> -- 
> 1.8.4.rc3
> 

