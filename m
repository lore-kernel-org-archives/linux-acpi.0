From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 1/1] Added an additional Sony laptop to
 acpi_osi_dmi_table
Date: Wed, 14 Oct 2009 18:48:49 -0700
Message-ID: <1255571329.22917.29.camel@desktop>
References: <1255568391-8400-1-git-send-email-timhoppen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932799AbZJOBu4@vger.kernel.org>
In-Reply-To: <1255568391-8400-1-git-send-email-timhoppen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Hoppen <timhoppen@gmail.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, jgarzik@redhat.com, tj@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2009-10-14 at 17:59 -0700, Tim Hoppen wrote:
> Signed-off-by: Tim Hoppen <timhoppen@gmail.com>
> ---
>  drivers/acpi/blacklist.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index e56b2a7..01cca5f 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -211,6 +211,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  		     DMI_MATCH(DMI_PRODUCT_NAME, "Sony VGN-SR290J"),
>  		},
>  	},
> +	{
> +        .callback = dmi_disable_osi_vista,
> +        .ident = "Sony VGN-FW351J",
> +        .matches = {
> +                     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +                     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW351J"),
> +                },
> +        },

It looks like your not indenting correctly. The above lines should be
tabbed instead of just spaced over .. You may have done copy and paste
on this block from the code around this. Copy and paste usually doesn't
properly copy the tabs .. Could you resubmit this with the tabbing added
back in?

Daniel 
