From: AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Mon, 16 Jul 2012 10:27:57 +0800
Message-ID: <CAMz9Wg-0Fzz8aeEqYpPRmVqDuFSTtOv=k7m6k1O0r7YB88zRuQ@mail.gmail.com>
References: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
	<20120713064801.GA4910@srcf.ucam.org>
	<CAMz9Wg9gJvABAbtZNZSuywq=GgK4KaufB8ph405SmErLpO1y4g@mail.gmail.com>
	<20120713071355.GA5516@srcf.ucam.org>
	<20120713141248.GE7877@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58998 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2GPC16 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2012 22:27:58 -0400
Received: by pbbrp8 with SMTP id rp8so9253937pbb.19
        for <linux-acpi@vger.kernel.org>; Sun, 15 Jul 2012 19:27:57 -0700 (PDT)
In-Reply-To: <20120713141248.GE7877@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

2012/7/13 Henrique de Moraes Holschuh <hmh@hmh.eng.br>:
> On Fri, 13 Jul 2012, Matthew Garrett wrote:
>> On Fri, Jul 13, 2012 at 03:07:38PM +0800, AceLan Kao wrote:
>> > There are many different events to inform the system concurrently,
>> > evdev is just one of them.
>> > I'm not sure which one trigger the system to suspend while pressing
>> > the suspend hotkey, but
>> > the following suspends are triggered by acpi proc event.
>>
>> I'm fine with killing the procfs interface (it's deprecated anyway, I
>> think?) but I'm a little worried about this only handling one case. Is
>> userspace guaranteed to ignore any further events that were delivered
>> over the input layer.
>
> No.  Some firmware (thinkpads) even used to latch state and refuse to
> reissue sleep buttom events for a while...
>
> Is there any reason why we cannot do the same?  Entering S3/S4 is a
> really good time to flush the contents of any input device and acpi
> [userspace] event queues at first glance...
thinkpads use its own thinkpad_acpi driver to handle this, it will submit
events to proc acpi event by itself through acpi_bus_generate_proc_event().

And BTW, I found a ThinkPad X220 and do the test, it won't enter S3 multiple
times if I press the suspend keys many times. And I try to remove thinkpad_acpi
module and stop the acpid and press the button again, the system enter S3
correctly, too. So, it won't damage this function from removing proc acpi event.

So, I didn't get the point why we can just remove the event, we don't rely on it
to enter S3 now, and to take into account that it's deprecated since
2007(fb804714),
I don't think we should do more workaround for this.

-- 
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
