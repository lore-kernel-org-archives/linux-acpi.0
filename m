From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend PATCH V2 7/7] usb/acpi: add usb check for the connect
 type of usb port
Date: Mon, 07 May 2012 09:37:54 +0800
Message-ID: <4FA72772.20604@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-8-git-send-email-tianyu.lan@intel.com> <201205040837.55905.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25869 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894Ab2EGBm7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 May 2012 21:42:59 -0400
In-Reply-To: <201205040837.55905.oneukum@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com

On 2012=E5=B9=B405=E6=9C=8804=E6=97=A5 14:37, Oliver Neukum wrote:
> Am Freitag, 4. Mai 2012, 05:06:43 schrieb Lan Tianyu:
>> +enum usb_port_connect_type {
>> +       USB_PORT_CONNECT_TYPE_UNKNOWN =3D 0,
>> +       USB_PORT_CONNECT_TYPE_HOT_PLUG,
>> +       USB_PORT_CONNECT_TYPE_HARD_WIRED,
>> +       USB_PORT_NOT_USED,
>> +};
>
> Is this actually useful? If we have ports known to ACPI (eg. hotplugg=
ed PCcard)
> we must assume the ports are fully hotpluggable.
Yeah. I think we can treat these three type ports differently. For exam=
ple,
the port is hard wired and we don't need to concern about hot plug sinc=
e
the device will not be removed physically.
>
> 	Regards
> 		Oliver

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
