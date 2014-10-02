From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Thu, 02 Oct 2014 16:55:56 +0200
Message-ID: <2072038.Vir4futZot@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <3986527.L7rDZAb4g5@wuerfel> <20141002143809.GQ1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63799 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbaJBO4B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Oct 2014 10:56:01 -0400
In-Reply-To: <20141002143809.GQ1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Thursday 02 October 2014 17:38:09 Mika Westerberg wrote:
> On Thu, Oct 02, 2014 at 04:29:03PM +0200, Arnd Bergmann wrote:
> > Is this a limitation in the way that the AML syntax and compiler works,
> > or is this a decision you made specifically for the _DSD syntax and that
> > could still be changed if there is an overwhelming interest?
> 
> It is only limitation of the _DSD device property UUID specification and
> our implementation. It can be changed if needed.

Ok, I see. I think it would be nice if this could be changed in order
to avoid having to copy the #xxx-cells and xxx-names properties from
DT, by providing a more natural syntax.

I'm not blaming you though if you don't want to go through the pain of
updating the spec though, and I won't complain loudly if you don't.

Maybe someone else has an opinion on the matter.

	Arnd
