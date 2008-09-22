From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Mon, 22 Sep 2008 18:38:24 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809221830331.1509@localhost.localdomain>
References: <20080702090044.GB12272@prithivi.gnumonks.org>
 <20080704034419.GG4381@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:34872 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbYIVXim (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 19:38:42 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K7M0078SC84XDL1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 22 Sep 2008 17:38:29 -0500 (CDT)
In-reply-to: <20080704034419.GG4381@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

Harald,
Thanks for picking up this driver -- I'm sure its users will be pleased
to get it included in the kernel.

I've got a couple of nitpicks I'd like you to fix
before I can merge it...

Please move the driver source to drivers/misc,
where the other laptop drivers live.
drivers/acpi/ is not for reverse-engineered platform drivers.

Also, please consider changing the driver's name.
toshiba_acpi is the oldtest, but least maintained driver of all
the laptop platform drivers, so it isn't a good example.

A better example is drivers/misc/*-laptop.c

If this works on a broad range of panasonic, the panasonic-laptop
panasonic make sense, else if it is more limited, then a more
specific name would be better.  Unclear what pcc stands for...

Also, you can delete this line:

-#include <linux/proc_fs.h>

and this

-/* definitions for /proc/ interface */

since you no longer have a /proc/interface.

thanks,
-Len

ps. I'll keep your previous version in my test tree until
you send along a new version, which hopefully we can merge into .28.


