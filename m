From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on Toshiba Satellite A40
Date: Thu, 20 Sep 2007 22:01:15 +0200
Message-ID: <200709202201.16487.rjw@sisk.pl>
References: <200709192014.08443.elendil@planet.nl> <46F29965.8030603@gmail.com> <46F2A122.8020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39851 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbXITTsR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Sep 2007 15:48:17 -0400
In-Reply-To: <46F2A122.8020909@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Maciek Rutecki <maciej.rutecki@gmail.com>, Frans Pop <elendil@planet.nl>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, 20 September 2007 18:34, Alexey Starikovskiy wrote:
> Maciek Rutecki wrote:
> > Frans Pop pisze:
> >> On Thursday 20 September 2007, you wrote:
> >>>> When compared with 2.6.22-4, dmesg no longer lists S4 and S5 as
> >>>> supported for my Toshiba Satellite A40 laptop (Mobile Intel Pentium 4,
> >>>> 2.8GHz).
> >>>>
> >>>> -Linux version 2.6.22-2-686 (Debian 2.6.22-4) (waldi@debian.org) ...
> >>>> +Linux version 2.6.23-rc6 (root@faramir) ...
> >>>>  [...]
> >>>> -ACPI: (supports S0 S3 S4 S5)
> >>>> +ACPI: (supports S0 S3)
> >>> Unexpected, and potentially pretty serious. Something went wrong with
> >>> ACPI. Can you try to narrow down when it started happening?
> >> rc1 still had all 4 levels. I'll run a bisect between rc1 and rc6.
> > 
> > I have the same on HP/Compaq nx6310:
> > ACPI: (supports S0 S3)
> This is due to Rafael' split of suspend from hibernation. 
> namely 296699de6bdc717189a331ab6bbe90e05c94db06.
> Detection of S4 lacks printk(), so even if S4 is supported, it will not be reported.
> Adding Rafael to the discussion :)

Thanks, I've already spotted the fix patch.

Greetings,
Rafael
