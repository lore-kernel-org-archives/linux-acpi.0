From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: BUG REPORT backlight acpi: Brightness shortcuts don't work on
 Fujitsu
Date: Wed, 04 Jun 2014 10:34:47 +0800
Message-ID: <538E85C7.5030809@intel.com>
References: <538D7845.9010305@gmail.com> <538D80C4.5080901@intel.com> <538D91B4.7050209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24496 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214AbaFDCeu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jun 2014 22:34:50 -0400
In-Reply-To: <538D91B4.7050209@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremie Tamburini <jeremie.tamburini@gmail.com>, linux-acpi@vger.kernel.org

On 06/03/2014 05:13 PM, Jeremie Tamburini wrote:
> Il 03/06/2014 10:01, Aaron Lu ha scritto:
>> On 06/03/2014 03:24 PM, Jeremie Tamburini wrote:
>>>
>>> On Fujitsu Lifebook A512 pressing Fn+F6 or Fn+F7 the brightness doesn't
>>> change.
>>
>> Sounds like the notification isn't sent on hotkey press.
>> Please attach your acpidump:
>> # acpidump > acpidump.txt
>> either to your original bug report or create a new one at:
>> https://bugzilla.kernel.org under category ACPI/Power-Video.
> 
> In some ways the system is able to understand that I'm pressing 
> Fn+F6/Fn+F7. The pop-up indicator (this one 
> http://s1.postimg.org/dly8ordov/Brightness.png) is showing the 
> brightness level adjustment. Unfortunately the brightness itself doesn't 
> change.

Ah, OK, I think I have misunderstood you.
So you already have a workaround with a xorg.conf file and everything
works now, right? If that is the case, the only thing that needs to be
done is to add your system into the video module's DMI table so that the
acpi_video interface will not be created. This can be verified by adding
video.use_native_backlight=1 to kernel cmdline.

Thanks,
Aaron

> 
> Here is the acpidump.txt: 
> https://launchpadlibrarian.net/176842546/acpidump.txt
> 
> Best regards
> Jeremie
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

