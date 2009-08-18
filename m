From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 0/8] eeepc-laptop fixes
Date: Tue, 18 Aug 2009 16:44:27 +0100
Message-ID: <9b2b86520908180844p55bf64fdl46acdb550f2b2d51@mail.gmail.com>
References: <4A75B6C6.3020805@tuffmail.co.uk>
	 <71cd59b00908021018x3b4c0af2jde2ccf0218befa2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:33902 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759203AbZHRPo0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2009 11:44:26 -0400
Received: by fxm11 with SMTP id 11so364528fxm.39
        for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2009 08:44:27 -0700 (PDT)
In-Reply-To: <71cd59b00908021018x3b4c0af2jde2ccf0218befa2f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

On 8/2/09, Corentin Chary <corentin.chary@gmail.com> wrote:
> Thanks,
> Applied in acpi4asus eeepc tree:
> http://git.iksaif.net/?p=acpi4asus.git;a=shortlog;h=refs/heads/eeepc-laptop
> With two other patch on top of yours (wimax and __init).
> I think I'll send them for 2.6.32 because there is a lot of change.

That was the idea.  Thanks!  I am suspicious of your __init and
ABI-doc commits, I will have a closer look at them :-).

Unfortunately I can't pull your tree

$ git fetch git://git.iksaif.net/acpi4asus.git eeepc-laptop
git.iksaif.net[0: 88.191.73.63]: errno=Connection timed out
fatal: unable to connect a socket (Connection timed out)

Regards
Alan

ps. I hope to send two more patches for 2.6.32, to make rfkill-hotplug
work on the 900A (pending tester(s) from debian-eeepc), and fix an
rfkill memory leak on unload.
