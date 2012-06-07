From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's
 power
Date: Thu, 07 Jun 2012 14:45:09 +0800
Message-ID: <4FD04DF5.5060007@intel.com>
References: <Pine.LNX.4.44L0.1206061020080.1788-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20604 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944Ab2FGGvr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Jun 2012 02:51:47 -0400
In-Reply-To: <Pine.LNX.4.44L0.1206061020080.1788-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On 2012=E5=B9=B406=E6=9C=8806=E6=97=A5 22:21, Alan Stern wrote:
> On Wed, 6 Jun 2012, Lan Tianyu wrote:
>
>>> If "auto" does nothing, there's no reason to put it in this patch a=
t
>>> all.  It could be added in a later patch, along with its
>>> implementation.
>> OK. I prefer to remove "auto" option in this patch. We can further d=
iscuss
>> the function of "auto".
>
> Sounds good.
>
> One more problem -- your implementation of "off" isn't quite right.
> You need to update hub_power_on() too.
>
How about this?

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -861,7 +861,9 @@ static unsigned hub_power_on(struct usb_hub *hub, b=
ool do_delay)
                 dev_dbg(hub->intfdev, "trying to enable port power on =
"
                                 "non-switchable hub\n");
         for (port1 =3D 1; port1 <=3D hub->descriptor->bNbrPorts; port1=
++)
-               set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER)=
;
+               if (hub->port_data[port1 - 1].port_power_policy
+                               =3D=3D USB_PORT_POWER_ON)
+                       set_port_feature(hub->hdev, port1, USB_PORT_FEA=
T_POWER);

         /* Wait at least 100 msec for power to become stable */
         delay =3D max(pgood_delay, (unsigned) 100);


> Alan Stern
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
