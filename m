From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.624-rc1 regression] lost battery information
Date: Fri, 26 Oct 2007 22:57:53 +0200
Message-ID: <E1IlWFd-0002fD-6c@faramir.fjphome.nl>
References: <200710262024.06012.arvidjaar@mail.ru> <200710262120.22536.arvidjaar@mail.ru> <47222DF3.3040208@gmail.com> <200710262215.42939.arvidjaar@mail.ru> <472232D3.6000807@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml14.KPNXCHANGE.COM ([213.75.38.114]:41513 "EHLO
	hpsmtp-eml14.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758593AbXJZU5z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Oct 2007 16:57:55 -0400
In-reply-To: <472232D3.6000807@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: arvidjaar@mail.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Alexey Starikovskiy wrote:
> Andrey Borzenkov wrote:
>> is it in -rc1 or can you point me to the patch (I'd rather avoid having
>> to pull from different git trees). Thank you.
> No, it should be rc1.
>> 
>> And what about ACPI_PROCFS case? It still needs attention I believe.
> As you can see, there is info in /proc too:

I'm missing the info in /sys too, so it looks like the error in proc and
the missing info in /sys are related.

Alexey: do you have POWER_SUPPLY and/or AC/BATTERY compiled in or modular?
I wonder if that could make the difference.
