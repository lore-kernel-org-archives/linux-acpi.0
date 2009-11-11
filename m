From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] acpi: Provide default GPE handler if the firmware doesn't
Date: Wed, 11 Nov 2009 22:31:57 +0100
Message-ID: <200911112231.58027.rjw@sisk.pl>
References: <1257806687-6608-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37691 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758816AbZKKVaa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2009 16:30:30 -0500
In-Reply-To: <1257806687-6608-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com

On Monday 09 November 2009, Matthew Garrett wrote:
> Firmware may support using GPEs for system wakeup without providing any
> runtime GPE handlers. This prevents the use runtime power management on
> these devices even if the hardware supports it. This patch adds support
> for providing default GPE handlers if the firmware doesn't, allowing us
> to implement runtime power management on machines where it would be
> otherwise impossible.
> 
> This implementation adds basic support for Intel chipsets.

Do I think correctly it's based on top of the run-time PM patches?

> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/pci/pci-acpi.c |  119 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 119 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index dae90cc..7fff59c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -879,6 +879,124 @@ static struct acpi_bus_type acpi_pci_bus = {
>  	.find_bridge = acpi_pci_find_root_bridge,
>  };
>  
...
> +
> +static acpi_status acpi_pci_pme_notify(void *context)
> +{
> +	struct work_struct *work = kzalloc(sizeof(struct work_struct),
> +					   GFP_ATOMIC);

kzalloc(sizeof(*work), ...) would save you a few characters. :-)

> +
> +	if (work) {
> +		INIT_WORK(work, context);
> +		schedule_work(work);

Hmm.  Not sure if putting that into pm_wq wouldn't be better.

Thanks,
Rafael
