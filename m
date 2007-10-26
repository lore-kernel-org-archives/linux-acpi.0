From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.624-rc1 regression] lost battery information
Date: Fri, 26 Oct 2007 20:00:27 +0200
Message-ID: <E1IlTTv-0008RL-IH@faramir.fjphome.nl>
References: <200710262024.06012.arvidjaar@mail.ru> <47221C67.9050502@gmail.com> <200710262120.22536.arvidjaar@mail.ru>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml17.KPNXCHANGE.COM ([213.75.38.117]:45135 "EHLO
	hpsmtp-eml17.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752556AbXJZSA3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Oct 2007 14:00:29 -0400
In-reply-To: <200710262120.22536.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: aystarik@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> I already have power_supply module, battery depends on it and it is
> autloaded. But I fail to see where I can get battery info in /sys

Ah, yes. I see what you mean now and I can confirm the same regression wrt
missing battery data in /proc for my laptop.

$ cat /proc/acpi/battery/BAT1/*
cat: /proc/acpi/battery/BAT1/alarm: Bad address
cat: /proc/acpi/battery/BAT1/info: Bad address
cat: /proc/acpi/battery/BAT1/state: Bad address

Sorry for the earlier misunderstanding.
