From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/5] PCI: hotplug: remove acpi_bus_generate_proc_event
Date: Mon, 10 Sep 2012 16:54:19 -0600
Message-ID: <CAErSpo7FAZvpWvhYCPUL8X1LBKmArUg3BYuCthwcKTeHR4nu+w@mail.gmail.com>
References: <1346630607.3170.31.camel@offbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48764 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab2IJWym (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Sep 2012 18:54:42 -0400
Received: by lbbgj3 with SMTP id gj3so1573877lbb.19
        for <linux-acpi@vger.kernel.org>; Mon, 10 Sep 2012 15:54:40 -0700 (PDT)
In-Reply-To: <1346630607.3170.31.camel@offbook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dave@gnu.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Mauro Carvalho Chehab <mchehab@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sun, Sep 2, 2012 at 6:03 PM, Davidlohr Bueso <dave@gnu.org> wrote:
> Calling this function no longer makes sense as /proc/acpi/event
> is being removed.
>
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this series will be applied as a group somewhere other than
the PCI tree.  Let me know if you need me to do anything more than ack
this one.

> ---
>  drivers/pci/hotplug/acpiphp_ibm.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
> index c35e8ad..5394fff 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -270,7 +270,6 @@ static void ibm_handle_events(acpi_handle handle, u32 event, void *context)
>
>         if (subevent == 0x80) {
>                 dbg("%s: generationg bus event\n", __func__);
> -               acpi_bus_generate_proc_event(note->device, note->event, detail);
>                 acpi_bus_generate_netlink_event(note->device->pnp.device_class,
>                                                   dev_name(&note->device->dev),
>                                                   note->event, detail);
> --
> 1.7.4.1
>
>
>
>
