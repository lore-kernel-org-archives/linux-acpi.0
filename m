From: Thomas Ibbotson <thomas.ibbotson@gmail.com>
Subject: Re: Rotating tablet screen updates lid state but doesn't generate an
	event
Date: Sun, 7 Feb 2010 15:16:30 +0000
Message-ID: <d8f0f0df1002070716i471737d4te848b4ae209ae3c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f211.google.com ([209.85.220.211]:37451 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab0BGPQc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Feb 2010 10:16:32 -0500
Received: by fxm3 with SMTP id 3so6390899fxm.39
        for <linux-acpi@vger.kernel.org>; Sun, 07 Feb 2010 07:16:31 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Toby Cubitt <tsc25 <at> cantab.net> writes:

>
> Hi,
>
> I hope this is the right list to post this kind of question.
>
> I'm running a 2.6.23 kernel (with the tuxonice and Gentoo patchsets
> applied) on a Toshiba Portege M400 tablet PC, and I have the legacy
> /proc/acpi support built into the kernel (CONFIG_ACPI_PROCFS=y and
> CONFIG_ACPI_PROC_EVENT=y), since acpid still depends on it for now. I
> also have Toshiba ACPI support built into the kernel, in case that's
> also relevant (CONFIG_ACPI_TOSHIBA=y).
>
> When I open or close the lid as on a normal laptop,
> /proc/acpi/button/lid/LID/state is updated and acpi
> "button/lid" events are generated in /proc/acpi/event, as expected.
> However, when I rotate the screen into tablet mode, although the lid
> state is updated to "closed", nothing is generated in /proc/acpi/event.
> Then, when I lift the lid to rotate it back to normal laptop position, a
> "button/lid" event _is_ generated in /proc/acpi/event, identical to
> normal lid events (and the lid state is updated to "open").
>
> So it seems as though acpi is correctly identifying closing the lid and
> rotating the screen into tablet mode as two different types of events,
> but isn't writing anything to /proc/acpi/event for the latter. On the
> other hand, it is generating identical events for both opening the lid
> and rotating the screen back to laptop mode.
>
> I guess the correct behaviour would be along the lines of what
> apparently happens in Thinkpad tablets: opening and closing the lid
> should generate "button/lid" events, and rotating the screen to and from
> tablet mode should generate a different type of event. (Though if
> the kernel just generated any event other than "button/lid" when the
> screen was rotated to tablet mode, it would still be usable.)
>
> I'm happy to provide more information if it would be helpful, but I have
> no experience at all in helping debug kernel code, so I'm not sure what
> I should be telling you.
>
> Thanks for any help,
>
> Toby

Hi,

I am having exactly the same problem with a Toshiba Portege R400. Can anyone
point me in the right direction for tackling this issue?

Thanks,
Tom
