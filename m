From: Martin Zuther <mz_mail@mzuther.de>
Subject: Yet another DSDT problem
Date: Sun, 10 Sep 2006 22:43:40 +0200
Message-ID: <450478FC.2080309@mzuther.de>
References: <200609041332.19780.rjw@sisk.pl> <200609071234.21782.rjw@sisk.pl> <20060907220837.GI29890@elf.ucw.cz> <200609080022.26726.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail2.dbdserver.de ([212.88.144.29]:44456 "EHLO
	mail2.dbdserver.de") by vger.kernel.org with ESMTP id S964918AbWIJUkY
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Sep 2006 16:40:24 -0400
Received: from [145.254.135.71] (dialin-145-254-135-071.pools.arcor-ip.net [145.254.135.71])
	by mail2.dbdserver.de (Postfix) with ESMTP id 8C340278010
	for <linux-acpi@vger.kernel.org>; Sun, 10 Sep 2006 22:40:21 +0200 (CEST)
In-Reply-To: <200609080022.26726.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear list members,

It doesn't seem to work. So I'll only give a synopsis of my problem here
- the full problem report can be found at:

  http://www.mzuther.de/data/linux-acpi_01.txt

while the original DSDT is here:

  http://www.ubuntuusers.de/paste/2441/?format=txt

My system doesn't shut down properly. Kubuntu also hints that I have a
partial ACPI installation, which is probably related to "acpi -V"
producing the error message "No support for device type: thermal"...

On shutdown my hard drives click, and that's about as near as I ever get
to shutting down my computer. The only thing working at this stage are
pressing the power or reset button.

Also, when I reboot the computer from KDE, it does as told, but when in
the BIOS routines, there's a noticeable pause and a click when my two
S-ATA drives are checked. I don't have a problem like that when
rebooting other OS's.

Here are the warnings I found when recompiling the DSDT:

  Warning  1086 - Not all control paths return a value (STM_)

  Warning  1079 - Reserved method must return a value (_WAK)

For the second warning I use the googled "standard solution", so the
problem seems to lie within the first warning. As my machine code
knowledge is based on the Z80 and was lost somewhere years ago, I'd like
to ask for your help. I also checked the WWW and the ACPI spec for
ideas, but couldn't come up with anything useful.

Any help is deeply appreciated!

Martin

