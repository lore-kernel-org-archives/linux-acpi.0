From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: /proc/acpi/wakeup regression in 2.6.39-rc3
Date: Fri, 15 Apr 2011 00:53:36 +0200
Message-ID: <201104150053.37037.rjw@sisk.pl>
References: <20110414222525.GA24365@mac.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52118 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab1DNWxI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Apr 2011 18:53:08 -0400
In-Reply-To: <20110414222525.GA24365@mac.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Friday, April 15, 2011, Tino Keitel wrote:
> Hi,
> 
> with 2.6.38, I enabled wakeup from suspend to RAM with the USB keyboard
> this way:
> 
> echo USB2 > /proc/acpi/wakeup
> 
> This does not work anymore with 2.6.39-rc3. Wakeup using the keyboard
> won't work, and the USB2 line in /proc/acpi/wakeup doesn't change to
> "enabled" after the echo command.
> 
> Is this intended? If yes, what is the new way to enable keyboard
> wakeup?

No, it's supposed to work IIRC.  I'll have a look at that code tomorrow.

Thanks,
Rafael
