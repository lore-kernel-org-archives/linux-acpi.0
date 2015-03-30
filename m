From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/PMIC: Fix typo in MODULE_DESCRIPTION in intel_pmic_crc.c
Date: Mon, 30 Mar 2015 02:17:42 +0200
Message-ID: <1947712.Ql71BLcWVm@vostro.rjw.lan>
References: <1427292788-6739-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64755 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751631AbbC2Xxc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2015 19:53:32 -0400
In-Reply-To: <1427292788-6739-1-git-send-email-standby24x7@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Masanari Iida <standby24x7@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, aaron.lu@intel.com

On Wednesday, March 25, 2015 11:13:08 PM Masanari Iida wrote:
> This patch fix a spelling typo in MODULE_DESCRIPTION within intel_pmic_crc.c
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Queued up for 4.1, thanks!

> ---
>  drivers/acpi/pmic/intel_pmic_crc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_crc.c b/drivers/acpi/pmic/intel_pmic_crc.c
> index ef7d8ff..42df46a 100644
> --- a/drivers/acpi/pmic/intel_pmic_crc.c
> +++ b/drivers/acpi/pmic/intel_pmic_crc.c
> @@ -207,5 +207,5 @@ static int __init intel_crc_pmic_opregion_driver_init(void)
>  }
>  module_init(intel_crc_pmic_opregion_driver_init);
>  
> -MODULE_DESCRIPTION("CrystalCove ACPI opration region driver");
> +MODULE_DESCRIPTION("CrystalCove ACPI operation region driver");
>  MODULE_LICENSE("GPL");
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
