From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend PATCH V2 3/7] usb: Set device removable state based on
 ACPI USB data
Date: Wed, 09 May 2012 10:49:18 +0800
Message-ID: <4FA9DB2E.3040501@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-4-git-send-email-tianyu.lan@intel.com> <20120508173154.GA9171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54246 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2EICy3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 May 2012 22:54:29 -0400
In-Reply-To: <20120508173154.GA9171@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

On 2012=E5=B9=B405=E6=9C=8809=E6=97=A5 01:31, Greg KH wrote:
> On Fri, May 04, 2012 at 11:06:39AM +0800, Lan Tianyu wrote:
>> From: Matthew Garrett<mjg@redhat.com>
>>
>> ACPI offers two methods that allow us to infer whether or not a USB =
port
>> is removable. The _PLD method gives us information on whether the po=
rt is
>> "user visible" or not. If that's not present then we can fall back t=
o the
>> _UPC method which tells us whether or not a port is connectable.
>>
>> Signed-off-by: Matthew Garrett<mjg@redhat.com>
>> ---
>>   drivers/usb/core/usb-acpi.c |   56 +++++++++++++++++++++++++++++++=
++++++++++++
>>   1 files changed, 56 insertions(+), 0 deletions(-)
>
> This is getting frustrating...
Oh. So sorry to bring trouble with you. I found problem that we just te=
sted
the patchset with usbcore built in kernel rather than as a module. So
carelessness.
>
> After this patch I get the following build error:
> 	ERROR: "acpi_get_physical_device_location" [drivers/usb/core/usbcore=
=2Eko] undefined!
>
> Lan, please retest these, and resend them, with Matthew's other ACPI
> patch, after it's all working properly, and you have fixed this all u=
p.
> I've dropped all of these from my mailboxes now, you need to start ov=
er.
>
> Also, when you forward on a patch like this, and the others, please a=
lso
> sign-off-by: on it, or at least Ack: it, to keep you in the chain of =
bug
> reporting and stuff.
Thanks for remind. I will do that.
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
