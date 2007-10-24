From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update
 correctly
Date: Thu, 25 Oct 2007 00:32:53 +0400
Message-ID: <471FABF5.1030406@gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>	 <471F9494.8080503@gmail.com>	 <3e7b9f4b0710241252y731aec1sd46ca8c36438e9a6@mail.gmail.com> <3e7b9f4b0710241323p5bbee5a8r582264d0a2b10f60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:60740 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbXJXUdE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 16:33:04 -0400
Received: by ug-out-1314.google.com with SMTP id z38so396108ugc
        for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 13:33:03 -0700 (PDT)
In-Reply-To: <3e7b9f4b0710241323p5bbee5a8r582264d0a2b10f60@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-acpi@vger.kernel.org

Ash Milsted wrote:
> On 24/10/2007, Ash Milsted <thatistosayiseenem@gawab.com> wrote:
>> On 24/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
>>> Could you please test this patch?
>> Appears to work again  - sysfs values now seem to update correctly
>> without help from a proc read. Will check without ACPI_PROCFS and let
>> you know if anything still seems wrong.
>>
>> Ash
>>
> 
> Okay, I have a further suspicion that uevents are not being sent as
> the battery charge changes. I have HAL 0.5.10 running and it only
> updates it's battery status if I (un)plug the power, despite cat
> /sys/class/power_supply/BAT1/charge_now now giving a current value.
> 
This one is not easy. According to code, it should send twice as many notifications now.
One over netlink, and one as power_supply class device...
Could you log all the uevents? 
