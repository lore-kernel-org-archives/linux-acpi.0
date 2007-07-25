From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [2.6.22] ACPI video problems with T60p laptop
Date: Tue, 24 Jul 2007 22:12:35 -0300
Message-ID: <20070725011235.GB778@khazad-dum.debian.net>
References: <974101.13462.qm@web52908.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57633 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757594AbXGYBMj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2007 21:12:39 -0400
Content-Disposition: inline
In-Reply-To: <974101.13462.qm@web52908.mail.re2.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 24 Jul 2007, Chris Rankin wrote:
> - The kernel is likely to lock up when the video.ko modules loads, if nmi_watchdog=1

NEVER use nmi_watchdog on thinkpads.  IBM/Lenovo's crap of a SMBIOS is
deeply alergic to NMIs while handling a SMI.

I don't know why the nmi_watchdog is not blacklisted on thinkpads, I recall
someone wanted to do that and sent a patch...

> - The VID/ directory appears twice in the /proc/acpi/video/ directory:
> 
> $ ls -alis /proc/acpi/video/
> total 0
> 4026532147 0 dr-xr-xr-x  4 root root 0 2007-07-24 22:17 .
> 4026531915 0 dr-xr-xr-x 12 root root 0 2007-07-24 19:27 ..
> 4026532169 0 dr-xr-xr-x  5 root root 0 2007-07-24 22:17 VID
> 4026532169 0 dr-xr-xr-x  5 root root 0 2007-07-24 22:17 VID

This is stuff that is overloaded by a SSDT in the thinkpad. Maybe something
is weird with that?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
