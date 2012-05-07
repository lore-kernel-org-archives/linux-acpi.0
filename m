From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend PATCH V2 3/7] usb: Set device removable state based on
 ACPI USB data
Date: Mon, 07 May 2012 09:38:15 +0800
Message-ID: <4FA72787.5000106@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-4-git-send-email-tianyu.lan@intel.com> <201205040824.17010.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15983 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754909Ab2EGBnU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 May 2012 21:43:20 -0400
In-Reply-To: <201205040824.17010.oneukum@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

On 2012=E5=B9=B405=E6=9C=8804=E6=97=A5 14:24, Oliver Neukum wrote:
> Am Freitag, 4. Mai 2012, 05:06:39 schrieb Lan Tianyu:
>>
>> From: Matthew Garrett<mjg@redhat.com>
>>
>> ACPI offers two methods that allow us to infer whether or not a USB =
port
>> is removable. The _PLD method gives us information on whether the po=
rt is
>> "user visible" or not. If that's not present then we can fall back t=
o the
>> _UPC method which tells us whether or not a port is connectable.
>
> How does this act on bluetooth devices that are (dis)connected by swi=
tches
> on laptops?
This depends on the bios. From my opinion, the bluetooth is device on t=
he
motherboard so it belongs to hard-wired type.
>
> 	Regards
> 		Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
