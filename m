From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Battery life difference
Date: Sat, 5 Jul 2008 16:17:01 +0300
Message-ID: <31e679430807050617u3fc706fasee9bb43a151c501f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:2286 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYGENRC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jul 2008 09:17:02 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1003695waf.23
        for <linux-acpi@vger.kernel.org>; Sat, 05 Jul 2008 06:17:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kernel development list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hello all,

I bought two x61s for testing purposes. One of them is running windows XP and
the other one is running clean ubuntu 8.04 with kernel 2.6.24-19. The problem
is that on windows that battery lasts around 3h30min and with linux 1h30min.

2 hours is a huge difference. Here's the scenario:

. x61s with windows xp
wifi on but not connected to any network, bluetooth on,
display is in the less brighten state.

. x61s with ubuntu 8.04
all radios off (modules removed and hw switch off),
display is in the less brighten state.
powertop runned and I did what it suggested me
to do. Also did some other stuff from thinkwiki on
how to reduce power consumption.

Well, what could still be using the system power so
much ?

Are we missing anything on the acpi implementation or
is it related to acpi integration to bus and device drivers ?

Anything I could help testing and maybe even coding, I
started reading the acpi specs and some notes on the
linux-acpi website.

One thing that called my attention is that D2 and D3 states
would require context save/restore opperations (not always
true in D2) and I can't see such feature in almost any drivers.

We're starting to plan it for omap drivers though due to omap3's
pm feature been able to reach off-states, but that's another
point and has nothing to do with x86.

Anyways, do we reach D2/D3 states anywhere ? I mean without
context save/restore we can't reach D3 and almost no D2 as well.

Any comments ?

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
