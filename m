From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 02:07:15 +0100
Message-ID: <200802210207.16350.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <200802210049.42820.rjw@sisk.pl> <200802201617.51387.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33479 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbYBUBIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 20:08:37 -0500
In-Reply-To: <200802201617.51387.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thursday, 21 of February 2008, Jesse Barnes wrote:
> On Wednesday, February 20, 2008 3:49 pm Rafael J. Wysocki wrote:
> > > And just to confirm that, I just tested the current DRM modules against a
> > > 2.6.23.15 kernel.
> >
> > In 2.6.23.x there's no second ->suspend() during hibernation, so no wonder.
> 
> In 2.6.23 it's just:
>   ->suspend()
>   ->resume()

->shutdown()

(that breaks wake up from S4 with many devices, including but not limited to
the RTC wake alarm).

>   *S4*
> ?
> 

Thanks,
Rafael
