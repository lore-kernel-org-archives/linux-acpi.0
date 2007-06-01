From: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Fri, 01 Jun 2007 23:12:27 +0200
Message-ID: <87k5un4bwk.fsf@goat.bogus.local>
References: <878xb35sje.fsf@goat.bogus.local> <200706012237.17375.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:61964 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762370AbXFAVME (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jun 2007 17:12:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, 1 June 2007 22:27, Olaf Dietsche wrote:
>> When I resume, everything seems to come up (fan becomes busy, disk and
>> dvd spin up for a short time),
>
> Hmm, what about the screen?

When the laptop is dead, screen remains black.

When I skip acpi_enter_sleep_state(), the screen works like everything
else.

Regards, Olaf.
