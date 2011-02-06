From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/5] ACPI: Tie ACPI backlight devices to PCI devices if possible
Date: Sun, 6 Feb 2011 21:35:07 +0100
Message-ID: <201102062135.08171.rjw@sisk.pl>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com> <1295033065-13450-5-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295033065-13450-5-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net
List-Id: linux-acpi@vger.kernel.org

On Friday, January 14, 2011, Matthew Garrett wrote:
> Dual-GPU machines may provide more than one ACPI backlight interface. Tie
> the backlight device to the GPU in order to allow userspace to identify
> the correct interface.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Sorry for the late response, but I've just realized there's a problem with this
patch.

> ---
>  drivers/acpi/video.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index a9eec8c..a18e497 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -782,6 +782,9 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
>  
>  	if (acpi_video_backlight_support()) {
>  		struct backlight_properties props;
> +		struct pci_dev *pdev;
> +		acpi_handle acpi_parent;
> +		struct device *parent = NULL;
>  		int result;
>  		static int count = 0;
>  		char *name;
> @@ -794,10 +797,20 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
>  			return;
>  		count++;
>  
> +		acpi_get_parent(device->dev->handle, &acpi_parent);
> +
> +		pdev = acpi_get_pci_dev(acpi_parent);
> +		if (pdev) {
> +			parent = &pdev->dev;
> +			pci_dev_put(pdev);
> +		}

I'm afraid you can't do that or suspend problems will happen.

Namely, the PM core assumes that parents will be registered before their
children and it is a very strong assumption.  If violated, it may lead to
a suspend sequence deadlock.

Unfortunately, it looks like the ACPI video device is registered before the
PCI device that's becoming it's parent, so the above assumption will be
violated.

Thanks,
Rafael
