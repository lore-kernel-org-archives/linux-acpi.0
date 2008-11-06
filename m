From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 02/11] ACPI: remove comments about debug layer/level to use
Date: Thu, 06 Nov 2008 15:30:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811061530240.3106@localhost.localdomain>
References: <20081105231710.26131.3110.stgit@bob.kio>
 <20081105231742.26131.76623.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:56357 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbYKFUrH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 15:47:07 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9X00GG4IAV6I10@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 14:30:32 -0600 (CST)
In-reply-to: <20081105231742.26131.76623.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

applied.

thanks,
-len

On Wed, 5 Nov 2008, Bjorn Helgaas wrote:

> I don't think there's any point in cluttering the code with these.
> Better to improve the documentation so *anybody* can figure out
> what layer & level to use.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/pci_root.c |    6 ------
>  drivers/acpi/video.c    |    6 ------
>  2 files changed, 0 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 1b8f67d..642554b 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -376,15 +376,9 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
>  
>  static int __init acpi_pci_root_init(void)
>  {
> -
>  	if (acpi_pci_disabled)
>  		return 0;
>  
> -	/* DEBUG:
> -	   acpi_dbg_layer = ACPI_PCI_COMPONENT;
> -	   acpi_dbg_level = 0xFFFFFFFF;
> -	 */
> -
>  	if (acpi_bus_register_driver(&acpi_pci_root_driver) < 0)
>  		return -ENODEV;
>  
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index a29b0cc..bf0c26a 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -2094,12 +2094,6 @@ static int __init acpi_video_init(void)
>  {
>  	int result = 0;
>  
> -
> -	/*
> -	   acpi_dbg_level = 0xFFFFFFFF;
> -	   acpi_dbg_layer = 0x08000000;
> -	 */
> -
>  	acpi_video_dir = proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
>  	if (!acpi_video_dir)
>  		return -ENODEV;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
