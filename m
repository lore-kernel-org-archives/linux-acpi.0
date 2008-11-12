From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [stable] Suspend regression in stable kernel 2.6.27.4 on Mac mini Core Duo
Date: Wed, 12 Nov 2008 22:41:08 +0100
Message-ID: <200811122241.09943.rjw@sisk.pl>
References: <20081109202830.GA7206@x61> <200811120103.55253.rjw@sisk.pl> <20081112073617.GA4996@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59728 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbYKLVgL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 16:36:11 -0500
In-Reply-To: <20081112073617.GA4996@dose.home.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tino Keitel <tino.keitel@gmx.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <greg@kroah.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wednesday, 12 of November 2008, Tino Keitel wrote:
> On Wed, Nov 12, 2008 at 01:03:54 +0100, Rafael J. Wysocki wrote:
> 
> [...]
> 
> > Also, can you check this patch on top of 2.6.27.4 and see what happens?
> 
> With that patch, resume works (although I used 2.6.27.5 and not
> 2.6.27.5, if that matters).

It shouldn't really matter.

Thanks for testing and please send me the output of dmidecode.
It seems that blacklisting may be the only way to handle your box. :-(

Thanks,
Rafael
