From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: acpica: dbfileio: Use strlcpy to Copy a C-string
 into a sized buffer
Date: Wed, 24 May 2017 14:15:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E59B15D@ORSMSX110.amr.corp.intel.com>
References: <1495581953-5523-1-git-send-email-karim.eshapa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495581953-5523-1-git-send-email-karim.eshapa@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

I'm not sure that strlcpy is portable.
Bob


> -----Original Message-----
> From: Karim Eshapa [mailto:karim.eshapa@gmail.com]
> Sent: Tuesday, May 23, 2017 4:26 PM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Zheng, Lv <lv.zheng@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; lenb@kernel.org; linux-
> acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org;
> Karim Eshapa <karim.eshapa@gmail.com>
> Subject: [PATCH] acpi: acpica: dbfileio: Use strlcpy to Copy a C-string
> into a sized buffer
> 
> Use strlcpy with sized buffer instead of strncpy to avoid non NUL-
> terminated source strings problems.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
>  drivers/acpi/acpica/dbfileio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/dbfileio.c
> b/drivers/acpi/acpica/dbfileio.c index 4d81ea2..f0f22f1 100644
> --- a/drivers/acpi/acpica/dbfileio.c
> +++ b/drivers/acpi/acpica/dbfileio.c
> @@ -99,7 +99,7 @@ void acpi_db_open_debug_file(char *name)
>  	}
> 
>  	acpi_os_printf("Debug output file %s opened\n", name);
> -	strncpy(acpi_gbl_db_debug_filename, name,
> +	strlcpy(acpi_gbl_db_debug_filename, name,
>  		sizeof(acpi_gbl_db_debug_filename));
>  	acpi_gbl_db_output_to_file = TRUE;
>  }
> --
> 2.7.4
