From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to disk
Date: Tue, 11 Apr 2006 22:35:18 +0200
Message-ID: <200604112235.18943.rjw@sisk.pl>
References: <443C0C2D.1020207@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:62171 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751302AbWDKUgV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Apr 2006 16:36:21 -0400
In-Reply-To: <443C0C2D.1020207@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Heimanns <ch.heimanns@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>

Hi,

On Tuesday 11 April 2006 22:06, Christian Heimanns wrote:
> Hello to all,
> following situation:
> On my notebook Samsung X20 1730V I'm running Slackware 10.2 current with
> kernel 2.6.15.6. Suspend to RAM and suspend to disk works fine.
> Since kernel >= 2.6.16 suspend to disk breaks the restore of the
> X-Server. That means that the current sessions is lost and the X-Server
> restarts.

Does it resume successfully without X (ie. runlevel 3)?

> No problems with suspend to RAM. Please find attached the 
> dmesg output for kernel 2.6.15.6 and 2.6.16.2. As well there is the
> output frpm lspci. The only difference I can find is that I have with
> kernel 2.6.16 some

Do you use a framebuffer driver and if so, is it modular?

Greetings,
Rafael
