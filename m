From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 41/98] ACPICA: FADT: Fix extraneous length mismatch warning
Date: Thu, 2 Apr 2009 13:53:11 +0200
Message-ID: <200904021353.12706.trenn@suse.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <aab61b676a024d3527f6201e2b31285a96f7a1d2.1238214619.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57139 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbZDBLxQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Apr 2009 07:53:16 -0400
In-Reply-To: <aab61b676a024d3527f6201e2b31285a96f7a1d2.1238214619.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

On Saturday 28 March 2009 05:31:16 Len Brown wrote:
> From: Bob Moore <robert.moore@intel.com>
> 
> Incorrect register length mismatch between the 32 and 64 bit
> registers in some cases. Code was was checking the wrong pointer
> for non-zero, should be looking at the address within the GAS
> structure.
> 
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/acpica/tbfadt.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/tbfadt.c 
b/drivers/acpi/acpica/tbfadt.c
> index af8fbe1..ff89cfe 100644
> --- a/drivers/acpi/acpica/tbfadt.c
> +++ b/drivers/acpi/acpica/tbfadt.c
> @@ -491,7 +491,8 @@ static void acpi_tb_validate_fadt(void)
>  		 * For each extended field, check for length mismatch between the
>  		 * legacy length field and the corresponding 64-bit X length 
field.
>  		 */
> -		if (address64 && (address64->bit_width != ACPI_MUL_8(length))) {
> +		if (address64->address &&
> +		    (address64->bit_width != ACPI_MUL_8(length))) {
>  			ACPI_WARNING((AE_INFO,
>  				      "32/64X length mismatch in %s: %d/%d",
>  				      name, ACPI_MUL_8(length),
This is a firmware bug for sure and should be marked as such.
ACPI_WARNING((AE_INFO, FW_BUG "32/64X
Can acpica take over and implement these from include/kernel.h if 
compiled standalone:
#define FW_BUG          "[Firmware Bug]: "
#define FW_WARN         "[Firmware Warn]: "
#define FW_INFO         "[Firmware Info]: "

     Thomas
