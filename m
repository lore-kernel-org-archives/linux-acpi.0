From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] ACPI: button: Add a debug message when we're sending a LID event
Date: Sat, 16 Dec 2017 02:55:36 +0100
Message-ID: <7002033.bktzKyE5gh@aspire.rjw.lan>
References: <20171122150612.16999-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64213 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756597AbdLPB4W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 20:56:22 -0500
In-Reply-To: <20171122150612.16999-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wednesday, November 22, 2017 4:06:11 PM CET Hans de Goede wrote:
> I've been debugging some spurious suspend issues on various devices,
> at least on some devices these spurious suspends are caused by surious
> LID closed events being send to userspace.
> 
> Running e.g. evemu-record after noticing a spurious suspend is too late
> to detect that a LID closed event it the (probable) cause of this.
> 
> This commit adds an acpi_handle_debug call to help debugging this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use acpi_handle_debug instead of pr_info
> ---
>  drivers/acpi/button.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index bf8e4d371fa7..aac81f40e28e 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -210,6 +210,8 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
>  	}
>  	/* Send the platform triggered reliable event */
>  	if (do_update) {
> +		acpi_handle_debug(device->handle, "ACPI LID %s\n",
> +				  state ? "open" : "closed");
>  		input_report_switch(button->input, SW_LID, !state);
>  		input_sync(button->input);
>  		button->last_state = !!state;
> 

Both this and the [2/2] applied, thanks!


