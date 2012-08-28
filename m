From: AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Tue, 28 Aug 2012 14:36:33 +0800
Message-ID: <CAMz9Wg_8cVopGsPOhjRGuHRvX7ZSu4cqnMEOYoQrMJBU9Wtv_Q@mail.gmail.com>
References: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
	<20120713064801.GA4910@srcf.ucam.org>
	<CAMz9Wg9gJvABAbtZNZSuywq=GgK4KaufB8ph405SmErLpO1y4g@mail.gmail.com>
	<20120713071355.GA5516@srcf.ucam.org>
	<20120713141248.GE7877@khazad-dum.debian.net>
	<CAMz9Wg-0Fzz8aeEqYpPRmVqDuFSTtOv=k7m6k1O0r7YB88zRuQ@mail.gmail.com>
	<20120723133452.GA21838@srcf.ucam.org>
	<20120723144452.GA3467@khazad-dum.debian.net>
	<CAMz9Wg_AFzP4k7N8_+2zJiDC2t9Q-vTRzsi-aMia6rYKBr6Rqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64696 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2H1Ggf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Aug 2012 02:36:35 -0400
Received: by wibhr14 with SMTP id hr14so4323171wib.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Aug 2012 23:36:33 -0700 (PDT)
In-Reply-To: <CAMz9Wg_AFzP4k7N8_+2zJiDC2t9Q-vTRzsi-aMia6rYKBr6Rqw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>

Hi,

Do we have any conclusion about this patch?

Taking account of the proc acpi event is deprecated, it should be okay
to remove it.
I also verified this patch works well with ThinkPad X220, and once if
there is a problem,
then we should come out another fix for it, instead of preventing this
patch from being merged,
since we face an re-entering S3 issue now.
Thanks.

Best regards,
AceLan Kao.

2012/7/24 AceLan Kao <acelan.kao@canonical.com>:
> Hi,
>
> 2012/7/23 Henrique de Moraes Holschuh <hmh@hmh.eng.br>:
>> On Mon, 23 Jul 2012, Matthew Garrett wrote:
>>> On Mon, Jul 16, 2012 at 10:27:57AM +0800, AceLan Kao wrote:
>>> > So, I didn't get the point why we can just remove the event, we don't rely on it
>>> > to enter S3 now, and to take into account that it's deprecated since
>>> > 2007(fb804714),
>>> > I don't think we should do more workaround for this.
>>>
>>> I've no objection to removing the event, I just want to know why we
>>> don't also need a solution in the evdev path. Why is this not a problem
>>> there?
> Actually, it will enter S3 at most 2 times through evdev path.
> The keyevents will be emitted at once while pressing the hotkey,
> the GUI(gnome-power-manager under gnome, for instance) will do the reaction.
> So, I think GUI will just ignore the following sleep events.
> And it will enter another S3 after doing input_dev_release_keys() in
> drivers/input/input.c +2174 during resuming if the key is not thought
> to be released.
>
> The big difference between evdev and proc acpi event is that
> proc acpi event won't send out the next event until the current one is done.
> We can observe its behavior by "acpi_listen"
> It sends out the next event after the system wakeup, so that the
> system will enter S3 again.
> I didn't dig into the code where it queues the events, I just observed it.
>
>>
>> Indeed.
>>
>> And if it is related _directly_ to thinkpad-acpi, please state so.  Because
>> thinkpad-acpi does have legacy compatibility crap that can issue duplicated
>> events (same event over different paths: evdev, acpi procfs, acpi netlink)
>> but it is supposed to never do that unless actively configured to do so.
> This patch do nothing to thinkpad-acpi, and I have already verified
> that it won't
> damage the current behavior of thinkpad-acpi driver.
>
>>
>> --
>>   "One disk to rule them all, One disk to find them. One disk to bring
>>   them all and in the darkness grind them. In the Land of Redmond
>>   where the shadows lie." -- The Silicon Valley Tarot
>>   Henrique Holschuh
>
>
>
> --
> Chia-Lin Kao(AceLan)
> http://blog.acelan.idv.tw/
> E-Mail: acelan.kaoATcanonical.com (s/AT/@/)



-- 
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
