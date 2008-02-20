From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 02:06:55 +0100
Message-ID: <200802200206.57002.rjw@sisk.pl>
References: <b6a2187b0802191653q4dfaa32cl96b9278e97606ef0@mail.gmail.com> <200802191700.12050.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52429 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbYBTBIQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 20:08:16 -0500
In-Reply-To: <200802191700.12050.jesse.barnes@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Wednesday, 20 of February 2008, Jesse Barnes wrote:
> I found the same poweroff issue on my T61.  It turned out to be related to the 
> C state code disabling interrupts when it shouldn't iirc.  Booting 
> with 'idle=poll' seems to work around the problem.

However, this issue is supposed to be fixed in 2.6.25-rc2, so most probably
there is another problem in there.

Thanks,
Rafael
