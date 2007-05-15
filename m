From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21 -- polling /proc/acpi/battery/*/state breaks ibm_acpi
Date: Tue, 15 May 2007 00:04:25 -0300
Message-ID: <20070515030425.GD22949@khazad-dum.debian.net>
References: <20070514115354.GA16885@proton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59066 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753643AbXEODEb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2007 23:04:31 -0400
Content-Disposition: inline
In-Reply-To: <20070514115354.GA16885@proton>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Messer <andreas.messer@stud-mail.uni-wuerzburg.de>
Cc: linux-acpi@vger.kernel.org

On Mon, 14 May 2007, Andreas Messer wrote:
> Up to Kernel 2.6.20 ibm_acpi was working fine on my TP X21.
> At least all Fn + <?> Keys worked. Now, since 2.6.21 it generally
> works but: When some Application is polling /proc/acpi/battery/*/state,
> the Fn - Keys (and perhaps the Lid-Button) became disfunctional until
> the next reboot. (Terminating the App didn't help)
> I can also produce the problem with a simple loop on cmd-line:
> 
> while true; do cat /proc/acpi/battery/BAT0/state; done
> 
> I figured out, that after system boot I can do a
> cat /proc/acpi/battery/BAT0/state for at least 3 times without
> breaking ibm_acpi. But then suddenly the keys FN - Keys are dead.

Are you using the latest BIOS and EC firmware for the X21?

Also, does ec_intr=0 on the kernel command line makes any difference?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
