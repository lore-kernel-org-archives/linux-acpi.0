From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] hotplug: unlock in error path in acpiphp_enable_slot
Date: Sun, 24 Jan 2016 02:17:24 +0100
Message-ID: <1559503.GJNuT7qv7A@vostro.rjw.lan>
References: <1453581859-19565-1-git-send-email-wuninsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453581859-19565-1-git-send-email-wuninsu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Insu Yun <wuninsu@gmail.com>
Cc: lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu
List-Id: linux-acpi@vger.kernel.org

On Saturday, January 23, 2016 03:44:19 PM Insu Yun wrote:
> In acpiphp_enable_slot, there is a missing unlock path
> when error occurred. It needs to be unlocked before returning an error.
> 
> Signed-off-by: Insu Yun <wuninsu@gmail.com>

Applied, thanks!

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index ff53856..0b3e0bf 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -953,8 +953,10 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
>  {
>  	pci_lock_rescan_remove();
>  
> -	if (slot->flags & SLOT_IS_GOING_AWAY)
> +	if (slot->flags & SLOT_IS_GOING_AWAY) {
> +		pci_unlock_rescan_remove();
>  		return -ENODEV;
> +	}
>  
>  	/* configure all functions */
>  	if (!(slot->flags & SLOT_ENABLED))
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
