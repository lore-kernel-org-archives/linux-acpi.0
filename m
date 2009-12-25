From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Regression in module wmi since 2.6.32 (bisected to commit 1caab3c)
Date: Fri, 25 Dec 2009 21:58:30 +0000
Message-ID: <200912252158.31127.carlos@strangeworlds.co.uk>
References: <4B352513.90302@lwfinger.net> <200912252056.08436.carlos@strangeworlds.co.uk> <4B353035.4050208@lwfinger.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39731 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863AbZLYV6j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Dec 2009 16:58:39 -0500
In-Reply-To: <4B353035.4050208@lwfinger.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Friday 25 December 2009 21:35:49 Larry Finger wrote:
> Should I attach the files DSDT.dat, acpidump.out, or DSDT?

DSDT from /proc/acpi/dsdt will do fine for my purposes.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
