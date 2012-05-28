From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH 1/3] xhci: Add clear PORT_POWER feature process in
 the xhci_hub_control()
Date: Mon, 28 May 2012 13:54:50 +0800
Message-ID: <4FC3132A.1080502@intel.com>
References: <1337924882-17332-1-git-send-email-tianyu.lan@intel.com> <1337924882-17332-2-git-send-email-tianyu.lan@intel.com> <4FC35358.6080700@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4148 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab2E1GAz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 May 2012 02:00:55 -0400
In-Reply-To: <4FC35358.6080700@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andiry Xu <andiry.xu@amd.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

On 2012=E5=B9=B405=E6=9C=8828=E6=97=A5 18:28, Andiry Xu wrote:
> On 05/25/2012 01:48 PM, Lan Tianyu wrote:
>> This patch is to add process of clearing PORT_POWER feature request
>> for xhci hub.
>>
>> Signed-off-by: Lan Tianyu<tianyu.lan@intel.com>
>> ---
>>   drivers/usb/host/xhci-hub.c |    5 +++++
>>   1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub=
=2Ec
>> index 2732ef6..feb515e 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -827,6 +827,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
>>   			xhci_disable_port(hcd, xhci, wIndex,
>>   					port_array[wIndex], temp);
>>   			break;
>> +		case USB_PORT_FEAT_POWER:
>> +			temp =3D xhci_readl(xhci, port_array[wIndex])
>> +				&  ~PORT_POWER;
>
> You should not read the register again. Simply use temp&=3D ~PORT_POW=
ER
> is enough.
>
> Otherwise you must call xhci_port_state_to_neutral(temp) again before
> write it back to register.
hi andiry:
	Thanks for your reminder and I will take the first one.=09
>
> Thanks,
> Andiry
>
>> +			xhci_writel(xhci, temp,	port_array[wIndex]);
>> +			break;
>>   		default:
>>   			goto error;
>>   		}
>
>

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
