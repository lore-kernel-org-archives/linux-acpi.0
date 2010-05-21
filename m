From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/7] x86 platform drivers: hp-wmi Use consistent prefix string for messages.
Date: Fri, 21 May 2010 11:14:53 -0700
Message-ID: <201005211114.54902.dmitry.torokhov@gmail.com>
References: <1274451495-10252-1-git-send-email-trenn@suse.de> <1274451495-10252-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1274451495-10252-4-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: mjg@redhat.com, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday 21 May 2010 07:18:11 am Thomas Renninger wrote:
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: mjg@redhat.com
> CC: linux-acpi@vger.kernel.org
> CC: platform-driver-x86@vger.kernel.org
> ---
>  drivers/platform/x86/hp-wmi.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 7b086dd..e04715a 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -52,6 +52,8 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
>  #define HPWMI_WIRELESS_QUERY 0x5
>  #define HPWMI_HOTKEY_QUERY 0xc
> 
> +#define PREFIX "HP WMI: "


Better yet, define pr_fmt() and  switch to using pr_info() and friends.
dev_xxx() is another option too.

-- 
Dmitry
