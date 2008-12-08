From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [stable] Suspend regression in stable kernel 2.6.27.4 on Mac mini Core Duo
Date: Mon, 8 Dec 2008 12:25:44 +0100
Message-ID: <200812081225.44832.rjw@sisk.pl>
References: <20081109202830.GA7206@x61> <200811160004.17804.rjw@sisk.pl> <20081208075531.GA20779@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37288 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbYLHL0h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Dec 2008 06:26:37 -0500
In-Reply-To: <20081208075531.GA20779@dose.home.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tino Keitel <tino.keitel@gmx.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <greg@kroah.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Bob Copeland <me@bobcopeland.com>

On Monday, 8 of December 2008, Tino Keitel wrote:
> On Sun, Nov 16, 2008 at 00:04:16 +0100, Rafael J. Wysocki wrote:
> > On Thursday, 13 of November 2008, Rafael J. Wysocki wrote:
> 
> [...]
> 
> > > Please try the appended patch on top of the Linus' tree.
> > 
> > This patch also applies to current -stable, so you can test it on top of that.
> > 
> > I need your confirmation that the patch works to push it upstream.
> 
> Hi,
> 
> I saw that 2.6.27.8 still missed that fix, maybe because I forgot to
> send any confirmation. So, yes, this patch fixes the regression for me.

Thanks.

I sent the inclusion request to -stable, but apparently it was too late for
2.6.27.8.

Rafael
