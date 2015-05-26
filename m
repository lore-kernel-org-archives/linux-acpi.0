From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPICA: acpihelp: Update for new NFIT table GUIDs.
Date: Tue, 26 May 2015 02:21:53 +0200
Message-ID: <1983767.hMniFBfVuC@vostro.rjw.lan>
References: <cover.1432175162.git.lv.zheng@intel.com> <73c89eb8cd9b5777c5c990bbb06d3bb6992ec3b1.1432342221.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45050 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750934AbbEYX4Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 May 2015 19:56:25 -0400
In-Reply-To: <73c89eb8cd9b5777c5c990bbb06d3bb6992ec3b1.1432342221.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

On Monday, May 25, 2015 08:15:27 AM Lv Zheng wrote:
> From: Bob Moore <robert.moore@intel.com>
> 
> ACPICA commit 83727bed8f715685a63a9f668e73c60496a06054
> 
> Add original UUIDs/GUIDs to the acuuid.h file.
> Cleanup acpihelp output for UUIDs/GUIDs.
> 
> Link: https://github.com/acpica/acpica/commit/83727bed
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

This one and the [2/2] applied, thanks!

> ---
>  include/acpi/acuuid.h |   43 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
> index 4955d5e..7c6cbb0 100644
> --- a/include/acpi/acuuid.h
> +++ b/include/acpi/acuuid.h
> @@ -50,15 +50,40 @@
>   * Note2: This file is standalone and should remain that way.
>   */
>  
> -/* NFIT/NVDIMM */
> +/* Controllers */
>  
> -#define UUID_VOLATILE_MEMORY            "4F940573-DAFD-E344-B16C-3F22D252E5D0"
> -#define UUID_PERSISTENT_MEMORY          "79D3F066-F3B4-7440-AC43-0D3318B78CDB"
> -#define UUID_CONTROL_REGION             "F601F792-B413-5D40-910B-299367E8234C"
> -#define UUID_DATA_REGION                "3005AF91-865D-0E47-A6B0-0A2DB9408249"
> -#define UUID_VOLATILE_VIRTUAL_DISK      "5A53AB77-FC45-4B62-5560-F7B281D1F96E"
> -#define UUID_VOLATILE_VIRTUAL_CD        "30BD5A3D-7541-CE87-6D64-D2ADE523C4BB"
> -#define UUID_PERSISTENT_VIRTUAL_DISK    "C902EA5C-074D-69D3-269F-4496FBE096F9"
> -#define UUID_PERSISTENT_VIRTUAL_CD      "88810108-CD42-48BB-100F-5387D53DED3D"
> +#define UUID_GPIO_CONTROLLER            "4f248f40-d5e2-499f-834c-27758ea1cd3f"
> +#define UUID_USB_CONTROLLER             "ce2ee385-00e6-48cb-9f05-2edb927c4899"
> +#define UUID_SATA_CONTROLLER            "e4db149b-fcfe-425b-a6d8-92357d78fc7f"
> +
> +/* Devices */
> +
> +#define UUID_PCI_HOST_BRIDGE            "33db4d5b-1ff7-401c-9657-7441c03dd766"
> +#define UUID_I2C_DEVICE                 "3cdff6f7-4267-4555-ad05-b30a3d8938de"
> +#define UUID_POWER_BUTTON               "dfbcf3c5-e7a5-44e6-9c1f-29c76f6e059c"
> +
> +/* Interfaces */
> +
> +#define UUID_DEVICE_LABELING            "e5c937d0-3553-4d7a-9117-ea4d19c3434d"
> +#define UUID_PHYSICAL_PRESENCE          "3dddfaa6-361b-4eb4-a424-8d10089d1653"
> +
> +/* NVDIMM - NFIT table */
> +
> +#define UUID_VOLATILE_MEMORY            "4f940573-dafd-e344-b16c-3f22d252e5d0"
> +#define UUID_PERSISTENT_MEMORY          "79d3f066-f3b4-7440-ac43-0d3318b78cdb"
> +#define UUID_CONTROL_REGION             "f601f792-b413-5d40-910b-299367e8234c"
> +#define UUID_DATA_REGION                "3005af91-865d-0e47-a6b0-0a2db9408249"
> +#define UUID_VOLATILE_VIRTUAL_DISK      "5a53ab77-fc45-4b62-5560-f7b281d1f96e"
> +#define UUID_VOLATILE_VIRTUAL_CD        "30bd5a3d-7541-ce87-6d64-d2ade523c4bb"
> +#define UUID_PERSISTENT_VIRTUAL_DISK    "c902ea5c-074d-69d3-269f-4496fbe096f9"
> +#define UUID_PERSISTENT_VIRTUAL_CD      "88810108-cd42-48bb-100f-5387d53ded3d"
> +
> +/* Miscellaneous */
> +
> +#define UUID_PLATFORM_CAPABILITIES      "0811b06e-4a27-44f9-8d60-3cbbc22e7b48"
> +#define UUID_DYNAMIC_ENUMERATION        "d8c1a3a6-be9b-4c9b-91bf-c3cb81fc5daf"
> +#define UUID_BATTERY_THERMAL_LIMIT      "4c2067e3-887d-475c-9720-4af1d3ed602e"
> +#define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-7cb7b9f4e500"
> +#define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-bc9bbf4aa301"
>  
>  #endif				/* __AUUID_H__ */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
