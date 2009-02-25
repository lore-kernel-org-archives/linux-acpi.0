From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/4] eeepc-laptop: restore acpi_generate_proc_event()
Date: Wed, 25 Feb 2009 18:14:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902251814220.19092@localhost.localdomain>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-3-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-4-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:50129 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985AbZBYXOh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 18:14:37 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFN00IO39W247Y1@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Feb 2009 17:14:27 -0600 (CST)
In-reply-to: <1234722621-14498-4-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

applied

--
Len Brown, Intel Open Source Technology Center

On Sun, 15 Feb 2009, Corentin Chary wrote:

> Restore acpi_generate_proc_event() for backward
> compatibility with old acpi scripts.
> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---
>  drivers/platform/x86/eeepc-laptop.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index 786ed86..6f54fd1 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -557,13 +557,17 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
>  static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
>  {
>  	static struct key_entry *key;
> +	u16 count;
> +
>  	if (!ehotk)
>  		return;
>  	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
>  		notify_brn();
> +	count = ehotk->event_count[event % 128]++;
> +	acpi_bus_generate_proc_event(ehotk->device, event, count);
>  	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
>  					dev_name(&ehotk->device->dev), event,
> -					ehotk->event_count[event % 128]++);
> +					count);
>  	if (ehotk->inputdev) {
>  		key = eepc_get_entry_by_scancode(event);
>  		if (key) {
> -- 
> 1.6.1.2
> 
> 
