From: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Wed, 13 Jun 2007 21:56:57 +0200
Message-ID: <87fy4vmxva.fsf@goat.bogus.local>
References: <878xb35sje.fsf@goat.bogus.local> <20070612153102.GD5986@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:60849 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbXFMT5A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2007 15:57:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> resume from suspend to ram doesn't work for my laptop and never
>> has. So, this is not a regression.
[...]
> Beeping patch? It is in -mm now. noapic nolapic and nosmp are useful,
> too.

With the proprietary nvidia module, the laptop resumes, but the screen
stays black. Meanwhile I tested the nvidiafb module, with identical
results: machine comes back from suspend, but with a black screen. Now
I cann ssh into it and do a proper shutdown or whatever. This is of
course nonsatisfying and I'm still playing around.

I haven't tested noapic, nolapic so far. This is a UP kernel.

Regards, Olaf.
