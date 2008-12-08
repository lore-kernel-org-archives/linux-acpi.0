From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: [stable] Suspend regression in stable kernel 2.6.27.4 on Mac
	mini Core Duo
Date: Mon, 8 Dec 2008 08:55:31 +0100
Message-ID: <20081208075531.GA20779@dose.home.local>
References: <20081109202830.GA7206@x61> <20081113192656.GA5735@dose.home.local> <200811132318.13821.rjw@sisk.pl> <200811160004.17804.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:33820 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYLHHzj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 02:55:39 -0500
Content-Disposition: inline
In-Reply-To: <200811160004.17804.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <greg@kroah.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Bob Copeland <me@bobcopeland.com>

On Sun, Nov 16, 2008 at 00:04:16 +0100, Rafael J. Wysocki wrote:
> On Thursday, 13 of November 2008, Rafael J. Wysocki wrote:

[...]

> > Please try the appended patch on top of the Linus' tree.
> 
> This patch also applies to current -stable, so you can test it on top of that.
> 
> I need your confirmation that the patch works to push it upstream.

Hi,

I saw that 2.6.27.8 still missed that fix, maybe because I forgot to
send any confirmation. So, yes, this patch fixes the regression for me.

Regards,
Tino
