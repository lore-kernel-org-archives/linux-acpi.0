From: Andiry Xu <andiry.xu@amd.com>
Subject: Re: [RFC PATCH 1/3] xhci: Add clear PORT_POWER feature process in
 the xhci_hub_control()
Date: Mon, 28 May 2012 18:28:40 +0800
Message-ID: <4FC35358.6080700@amd.com>
References: <1337924882-17332-1-git-send-email-tianyu.lan@intel.com> <1337924882-17332-2-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:43496 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974Ab2E1C3v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 May 2012 22:29:51 -0400
In-Reply-To: <1337924882-17332-2-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

On 05/25/2012 01:48 PM, Lan Tianyu wrote:
> This patch is to add process of clearing PORT_POWER feature request
> for xhci hub.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/usb/host/xhci-hub.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 2732ef6..feb515e 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -827,6 +827,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  			xhci_disable_port(hcd, xhci, wIndex,
>  					port_array[wIndex], temp);
>  			break;
> +		case USB_PORT_FEAT_POWER:
> +			temp = xhci_readl(xhci, port_array[wIndex])
> +				& ~PORT_POWER;

You should not read the register again. Simply use temp &= ~PORT_POWER
is enough.

Otherwise you must call xhci_port_state_to_neutral(temp) again before
write it back to register.

Thanks,
Andiry

> +			xhci_writel(xhci, temp,	port_array[wIndex]);
> +			break;
>  		default:
>  			goto error;
>  		}


