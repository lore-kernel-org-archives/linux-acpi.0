From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Tue, 21 Mar 2006 17:09:25 -0500
Message-ID: <E1FLp2b-00011l-Fz@approximate.corpus.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B417863@pdsmsx403>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:33471 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1751802AbWCUWJs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Mar 2006 17:09:48 -0500
In-Reply-To: Your message of "Tue, 21 Mar 2006 17:11:29 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417863@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

Two more experiments:

  With a vanilla kernel, I faked EC0.UPDT() to just return 0x00, and the
  system hung on the second sleep.

  Then, again in the DSDT, I also faked the 4 _TMP methods (one in each
  thermal zone), and the system hung on the second sleep.

I think we've raced too far ahead by trying to debug many thermal zones
at once.  Perhaps there are two bugs.  So let's find them one by one.

One bug is quite repeatable and we know a lot about it. With all zones
except THM0 commented out, the system hung.  With the EC0.UPDT line in
THM0._TMP also commented out, the system didn't hang.  So there's a
problem related to the EC, even with only THM0.  And finding that
problem may giveideas for what else may be wrong.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
