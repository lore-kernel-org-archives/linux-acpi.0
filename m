From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Regression in module wmi since 2.6.32 (bisected to commit 1caab3c)
Date: Fri, 25 Dec 2009 20:56:08 +0000
Message-ID: <200912252056.08436.carlos@strangeworlds.co.uk>
References: <4B352513.90302@lwfinger.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60132 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbZLYU4T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Dec 2009 15:56:19 -0500
In-Reply-To: <4B352513.90302@lwfinger.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Friday 25 December 2009 20:48:19 Larry Finger wrote:
> If I modprobe wmi after the system is booted, the specific messages are as
>  follows:
> 
> ------------[ cut here ]------------
> WARNING: at fs/sysfs/dir.c:477 sysfs_add_one+0xd6/0xee()
> Hardware name: System Product Name
> sysfs: cannot create duplicate filename
> '/devices/virtual/wmi/05901221-D566-11D1-B2F0-00A0C9062910'

Interesting - what hardware is this? And can you post the DSDT?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
