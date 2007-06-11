From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] ACPI: dock: Send key=value pair instead of plain value
Date: Mon, 11 Jun 2007 15:18:51 -0700
Message-ID: <20070611151851.b6370105.kristen.c.accardi@intel.com>
References: <20070611221200.GA5675@homac.gate.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:65289 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109AbXFKWWV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2007 18:22:21 -0400
In-Reply-To: <20070611221200.GA5675@homac.gate.uni-erlangen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, 12 Jun 2007 00:12:00 +0200
Holger Macht <hmacht@suse.de> wrote:

> Send key=value pair along with the uevent instead of a plain value so that
> userspace (udev) can handle it like common environment variables.
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>

Acked-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

> ---
> 
> Patch applies to recent acpi-test tree
> 
> diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index dc3df93..877ca1c 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -336,13 +336,13 @@ static void hotplug_dock_devices(struct
>  static void dock_event(struct dock_station *ds, u32 event, int num)
>  {
>  	struct device *dev = &dock_device->dev;
> -	char event_string[7];
> +	char event_string[13];
>  	char *envp[] = { event_string, NULL };
>  
>  	if (num == UNDOCK_EVENT)
> -		sprintf(event_string, "UNDOCK");
> +		sprintf(event_string, "EVENT=undock");
>  	else
> -		sprintf(event_string, "DOCK");
> +		sprintf(event_string, "EVENT=dock");
>  
>  	/*
>  	 * Indicate that the status of the dock station has
> 
