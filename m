From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: hp-wmi and hp dv9000
Date: Thu, 11 Feb 2010 11:22:10 +0000
Message-ID: <9b2b86521002110322j5b3e4fc4mbf3fa02a19c791c6@mail.gmail.com>
References: <87wrylwizo.wl%peterc@chubb.wattle.id.au>
	 <4B72A784.2020004@tuffmail.co.uk>
	 <876364ycyl.wl%peterc@chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58749 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab0BKLWM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2010 06:22:12 -0500
Received: by bwz19 with SMTP id 19so230222bwz.28
        for <linux-acpi@vger.kernel.org>; Thu, 11 Feb 2010 03:22:10 -0800 (PST)
In-Reply-To: <876364ycyl.wl%peterc@chubb.wattle.id.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Chubb <peter.chubb@nicta.com.au>
Cc: Matthew Garrett <mjg@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>

On 2/10/10, Peter Chubb <peter.chubb@nicta.com.au> wrote:
>>>>>> "Alan" == Alan Jenkins <alan-jenkins@tuffmail.co.uk> writes:
>
> Alan> Peter Chubb wrote:
>>> Hi Alan.  I noticed you were last working on hp-wmi.  I'm finding
>>> that if I load hp-wmi then the wireless network does not work ---
>>> dmesg output always says `iwlagn 0000:02:00: Radio disabled by HW
>>> RF Kill switch' regardless of the position of the switch.
>
> I've discovered that if I load the rfkill module *before* hp-wmi then
> everything works properly.

Can you show me what "udevadm monitor -ke" reports in both cases?  Use
one of the 2.6.33-rc kernels, and show me your kernel config.

> Maybe there's a missing dependency?

If you've built the rfkill module, "modprobe hp-wmi" should load it
automatically.  If it didn't, then hp-wmi would fail to load.  So it
sounds more like a race condition.

> I
> hadn't even been building the rfkill input module before --- it
> doesn't get automatically selected.

Um.  rfkill-input is no longer a separate module.  You can disable it
individually, *if* you have CONFIG_EMBEDDED enabled.  If that causes
problems, we need to fix that as well (because rfkill-input is
theoretically going away).

Or perhaps you have rfkill as a whole disabled?  In that case, we'd
expect that hp-wmi wouldn't have any effect on the wireless.  If it
does, that's also a bug (albeit a more obscure one with an easy
workaround).

Regards
Alan
