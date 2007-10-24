From: "Ash Milsted" <thatistosayiseenem@gawab.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update correctly
Date: Thu, 25 Oct 2007 00:28:27 +0200
Message-ID: <3e7b9f4b0710241528j403e2ecboc29e03438034349a@mail.gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>
	 <471F9494.8080503@gmail.com>
	 <3e7b9f4b0710241252y731aec1sd46ca8c36438e9a6@mail.gmail.com>
	 <3e7b9f4b0710241323p5bbee5a8r582264d0a2b10f60@mail.gmail.com>
	 <471FABF5.1030406@gmail.com>
	 <3e7b9f4b0710241417i7f0edeel6d11b8a3e4048243@mail.gmail.com>
	 <471FBDF5.7000906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:51884 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbXJXW22 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 18:28:28 -0400
Received: by wr-out-0506.google.com with SMTP id 36so292317wra
        for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 15:28:27 -0700 (PDT)
In-Reply-To: <471FBDF5.7000906@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 24/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Ash Milsted wrote:
> > On 24/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> >> This one is not easy. According to code, it should send twice as many notifications now.
> >> One over netlink, and one as power_supply class device...
> >> Could you log all the uevents?
> >>
> > Forgive my ignorance, but I'm not entirely sure how to capture
> > uevents. If "udevmonitor --kernel" is sufficient then it appears there
> > are no events associated with the battery discharging or charging,
> > whereas those associated with (un)plugging do appear. To clarify, I've
> > seen cat /sys/.../charge_now change without udevmonitor picking up a
> > single kernel event.
> Could you try to insert prink() into acpi_battery_notify() in drivers/acpi/battery.c?
> This is the only place which could send uevent. If you don't see this printk in
> dmesg, then HAL uses some other method to get battery state changes.
>
I can confirm that this function is *not* called as the battery
(dis)charges (having seen charge_now fall), but is called on
power-plug events.
