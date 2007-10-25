From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update
 correctly
Date: Thu, 25 Oct 2007 07:08:53 +0400
Message-ID: <472008C5.8030906@gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>	 <471F9494.8080503@gmail.com>	 <3e7b9f4b0710241252y731aec1sd46ca8c36438e9a6@mail.gmail.com>	 <3e7b9f4b0710241323p5bbee5a8r582264d0a2b10f60@mail.gmail.com>	 <471FABF5.1030406@gmail.com>	 <3e7b9f4b0710241417i7f0edeel6d11b8a3e4048243@mail.gmail.com>	 <471FBDF5.7000906@gmail.com>	 <3e7b9f4b0710241528j403e2ecboc29e03438034349a@mail.gmail.com> <3e7b9f4b0710241537i1d3db590u2220900e30ae0d1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:13307 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421AbXJYDJE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 23:09:04 -0400
Received: by ug-out-1314.google.com with SMTP id z38so437865ugc
        for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 20:09:03 -0700 (PDT)
In-Reply-To: <3e7b9f4b0710241537i1d3db590u2220900e30ae0d1b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <ashmilsted@gmail.com>
Cc: linux-acpi@vger.kernel.org

Ash Milsted wrote:
> On 25/10/2007, Ash Milsted <thatistosayiseenem@gawab.com> wrote:
>> On 24/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
>>> Ash Milsted wrote:
>>>> On 24/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
>>>>> This one is not easy. According to code, it should send twice as many notifications now.
>>>>> One over netlink, and one as power_supply class device...
>>>>> Could you log all the uevents?
>>>>>
>>>> Forgive my ignorance, but I'm not entirely sure how to capture
>>>> uevents. If "udevmonitor --kernel" is sufficient then it appears there
>>>> are no events associated with the battery discharging or charging,
>>>> whereas those associated with (un)plugging do appear. To clarify, I've
>>>> seen cat /sys/.../charge_now change without udevmonitor picking up a
>>>> single kernel event.
>>> Could you try to insert prink() into acpi_battery_notify() in drivers/acpi/battery.c?
>>> This is the only place which could send uevent. If you don't see this printk in
>>> dmesg, then HAL uses some other method to get battery state changes.
>>>
>> I can confirm that this function is *not* called as the battery
>> (dis)charges (having seen charge_now fall), but is called on
>> power-plug events.
> Sorry... I mean it appears to be called on module-insertion and then
> *never* again (not on plug events).
> 
Could you please confirm, that there were no battery discharge uevents before, e.g in 2.6.23?
