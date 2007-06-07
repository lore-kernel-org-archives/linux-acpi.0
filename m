From: Olaf Dietsche <olaf.dietsche@olafdietsche.de>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Thu, 07 Jun 2007 21:54:51 +0200
Message-ID: <87tztjo7zo.fsf@goat.bogus.local>
References: <878xb35sje.fsf@goat.bogus.local> <200706012340.54394.rjw@sisk.pl>
	<87hcpr2ubl.fsf@goat.bogus.local> <200706020037.16615.rjw@sisk.pl>
	<87wsykpweu.fsf@goat.bogus.local> <20070607122303.GA8938@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58436 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762225AbXFGTxq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jun 2007 15:53:46 -0400
In-Reply-To: <20070607122303.GA8938@ucw.cz> (Pavel Machek's message of "Thu, 7
	Jun 2007 12:23:04 +0000")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

Pavel Machek <pavel@ucw.cz> writes:

>> But either way the script never reaches "shutdown -rn now". So, it
>> seems, that my laptop does a full resume every other reboot, but it
>> never returns to userspace.
>
> But it returns to kernel... can you use more trace points to figure
> out where it hangs?

I haven't looked, but I guess this is somewhere in sysfs.

I made some small progress. With the nvidia.ko kernel module loaded,
my laptop returns to userspace. I'll investigate this further.

Regards, Olaf.
