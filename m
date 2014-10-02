From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Thu, 2 Oct 2014 17:38:09 +0300
Message-ID: <20141002143809.GQ1786@lahna.fi.intel.com>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
 <15893883.nvuW3ndylz@wuerfel>
 <20141002133654.GP1786@lahna.fi.intel.com>
 <3986527.L7rDZAb4g5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13719 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbaJBOiT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Oct 2014 10:38:19 -0400
Content-Disposition: inline
In-Reply-To: <3986527.L7rDZAb4g5@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Thu, Oct 02, 2014 at 04:29:03PM +0200, Arnd Bergmann wrote:
> Is this a limitation in the way that the AML syntax and compiler works,
> or is this a decision you made specifically for the _DSD syntax and that
> could still be changed if there is an overwhelming interest?

It is only limitation of the _DSD device property UUID specification and
our implementation. It can be changed if needed.
