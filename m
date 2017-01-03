From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PCI: acpiphp_ibm: add __ro_after_init to ibm_apci_table_attr
Date: Tue, 3 Jan 2017 15:10:54 -0800
Message-ID: <CAGXu5jJCAvM8Du_29inQjs8ipN0GWdoWcjwpu1HGhyUkFsR2kA@mail.gmail.com>
References: <1482766595-12679-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36193 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbdACXLD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jan 2017 18:11:03 -0500
Received: by mail-io0-f175.google.com with SMTP id h133so205309444ioe.3
        for <linux-acpi@vger.kernel.org>; Tue, 03 Jan 2017 15:10:56 -0800 (PST)
In-Reply-To: <1482766595-12679-1-git-send-email-bhumirks@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Dec 26, 2016 at 7:36 AM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> The object ibm_apci_table_attr of type bin_attribute structure is not
> modified after getting initialized by ibm_acpiphp_init. Apart from
> getting referenced in init it is also passed as an argument to the functions
> sysfs_{remove/create}_bin_file but both the arguments are of type const
> struct bin_attribute *. Therefore add __ro_after_init to its declaration.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/pci/hotplug/acpiphp_ibm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
> index f6221d7..188cdfa 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -107,7 +107,7 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
>
>  static acpi_handle ibm_acpi_handle;
>  static struct notification ibm_note;
> -static struct bin_attribute ibm_apci_table_attr = {
> +static struct bin_attribute ibm_apci_table_attr __ro_after_init = {
>             .attr = {
>                     .name = "apci_table",
>                     .mode = S_IRUGO,

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Nexus Security
