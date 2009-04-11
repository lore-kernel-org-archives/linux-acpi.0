From: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Subject: Re: [linux-pm] [2.6.30-rc1-git2 regressions] Hibernation broken and (minor but annoying) audio problem
Date: Sat, 11 Apr 2009 22:18:01 +0200
Message-ID: <200904112218.02159.a.miskiewicz@gmail.com>
References: <200904100057.43827.rjw@sisk.pl> <49E0EC87.9080808@linux.intel.com> <alpine.LFD.2.00.0904111247320.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:62742 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbZDKUSI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Apr 2009 16:18:08 -0400
In-Reply-To: <alpine.LFD.2.00.0904111247320.4583@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Takashi Iwai <tiwai@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Heinz Diehl <htd@fancy-poultry.org>, Vegard Nossum <vegard.nossum@gmail.com>

On Saturday 11 of April 2009, Linus Torvalds wrote:
> On Sat, 11 Apr 2009, Arjan van de Ven wrote:
> > Now that I've been able to scan most of my mail; it looks like the
> > one-liner should just go in.
>
> Ok, I committed my one-liner, and then also reverted the ACPI battery
> workaround of removing __init, since the one-liner should fix that to=
o.

Tested - works here|.

> 			Linus


--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
