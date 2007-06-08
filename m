From: Olaf Dietsche <olaf.dietsche@olafdietsche.de>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Fri, 08 Jun 2007 15:07:27 +0200
Message-ID: <877iqeoar4.fsf@goat.bogus.local>
References: <878xb35sje.fsf@goat.bogus.local> <200706041013.49428.rjw@sisk.pl>
	<87hcpnpt4k.fsf@goat.bogus.local> <200706042302.45628.rjw@sisk.pl>
	<87y7ivo86z.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63756 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937143AbXFHNG2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jun 2007 09:06:28 -0400
In-Reply-To: <87y7ivo86z.fsf@goat.bogus.local> (Olaf Dietsche's message of
	"Thu, 07 Jun 2007 21:50:28 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de> writes:

> I installed the nvidia.ko (1.0-9755) kernel module and now the machine
> comes back to life. Although the screen stays black as before, I can
> type blindly "shutdown -r now" or ssh into the laptop.

Here's an update: when I additionally install the complete nvidia
package, including the binary X server modules, my screen becomes
active on resume.

This is not really satisfactory, since my console stays black. Anyway,
this is another step forward, nonetheless.

Regards, Olaf.
