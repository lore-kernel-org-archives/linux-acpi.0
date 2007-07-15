From: Jeff Garzik <jeff@garzik.org>
Subject: Re: pci-ids: add Lenovo PCI vendor ID
Date: Sun, 15 Jul 2007 07:52:10 -0400
Message-ID: <469A0A6A.9020208@garzik.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <1184422336812-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50048 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758679AbXGOLwR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 07:52:17 -0400
In-Reply-To: <1184422336812-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> thinkpad-acpi wants to differentiate IBM from Lenovo ThinkPads, and the PCI
> IDs are the best way to go about it for quirk tables and so on.  Add the
> missing Lenovo PCI ID to pci_ids.h.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Jeff Garzik <jeff@garzik.org>
> ---
>  include/linux/pci_ids.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 5b1c999..b5f54ca 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2067,6 +2067,8 @@
>  #define PCI_DEVICE_ID_ALTIMA_AC9100	0x03ea
>  #define PCI_DEVICE_ID_ALTIMA_AC1003	0x03eb
>  
> +#define PCI_VENDOR_ID_LENOVO		0x17aa
> +
>  #define PCI_VENDOR_ID_ARECA		0x17d3
>  #define PCI_DEVICE_ID_ARECA_1110	0x1110

Not sure why I'm CC'd :)  But of course I have an opinion :)  Usually we 
don't add these IDs until a driver is actually using them.  Just add it 
in the patch that starts using it in thinkpad-acpi.

	Jeff



