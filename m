From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH V3 3/8] usb: Bind devices to ACPI devices when possible
Date: Fri, 11 May 2012 14:55:35 +0800
Message-ID: <4FACB7E7.8000709@intel.com>
References: <1336575635-13120-1-git-send-email-tianyu.lan@intel.com> <1336575635-13120-4-git-send-email-tianyu.lan@intel.com> <20120510230142.GA11125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51511 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab2EKHAy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 03:00:54 -0400
In-Reply-To: <20120510230142.GA11125@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

=E4=BA=8E2012=E5=B9=B405=E6=9C=8811=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=BA=94=
 07=E6=97=B601=E5=88=8642=E7=A7=92,Greg KH=E5=86=99=E5=88=B0:
> On Wed, May 09, 2012 at 11:00:30PM +0800, Lan Tianyu wrote:
>> From: Matthew Garrett<mjg@redhat.com>
>>
>> Built-in USB devices will typically have a representation in the sys=
tem
>> ACPI tables. Add support for binding the two together so the USB cod=
e can
>> make use of the associated methods.
>>
>> Signed-off-by: Matthew Garrett<mjg@redhat.com>
>> Signed-off-by: Lan Tianyu<tianyu.lan@intel.com>
>
> This patch doesn't apply to my usb-next branch.
>
> Last time around, I hand-edited the patch, but I'm tired of doing tha=
t
> with this series, and it shows you didn't test it against my latest
> tree.
>
> This is getting annoying, what would you do in my situation?
Sincerely seek for your forgiver.  I tested them on the usb master tree
without not notice the usb-next branch existing. So sorry again. I will=
=20
update
them base on latest usb-next tree soon.
>
> Please try again...
>
> greg k-h



--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
