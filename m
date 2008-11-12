From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: [stable] Suspend regression in stable kernel 2.6.27.4 on Mac
	mini Core Duo
Date: Wed, 12 Nov 2008 08:36:17 +0100
Message-ID: <20081112073617.GA4996@dose.home.local>
References: <20081109202830.GA7206@x61> <20081111181925.GA5036@dose.home.local> <200811120048.06647.rjw@sisk.pl> <200811120103.55253.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:45987 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYKLHgL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 02:36:11 -0500
Content-Disposition: inline
In-Reply-To: <200811120103.55253.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <greg@kroah.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Nov 12, 2008 at 01:03:54 +0100, Rafael J. Wysocki wrote:

[...]

> Also, can you check this patch on top of 2.6.27.4 and see what happens?

With that patch, resume works (although I used 2.6.27.5 and not
2.6.27.5, if that matters).

Regards,
Tino
