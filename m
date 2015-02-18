From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / LPSS: Deassert resets for SPI host
 controllers on Braswell
Date: Wed, 18 Feb 2015 18:13:03 +0200
Message-ID: <20150218161303.GT1508@lahna.fi.intel.com>
References: <1424260217-7719-1-git-send-email-mika.westerberg@linux.intel.com>
 <1424260217-7719-2-git-send-email-mika.westerberg@linux.intel.com>
 <3423831.zXJf7A6g9H@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55377 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041AbbBRQP4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Feb 2015 11:15:56 -0500
Content-Disposition: inline
In-Reply-To: <3423831.zXJf7A6g9H@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Yang A Fang <yang.a.fang@intel.com>, Yu Chen <yu.c.chen@intel.com>

On Wed, Feb 18, 2015 at 05:25:09PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 18, 2015 01:50:17 PM Mika Westerberg wrote:
> > On some Braswell systems BIOS leaves resets for SPI host controllers
> > active. This prevents the SPI driver from transferring messages on wire.
> > 
> > Fix this in similar way that we do for I2C already by deasserting resets
> > for the SPI host controllers.
> > 
> > Reported-by: Yang A Fang <yang.a.fang@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> OK, so these two would need to go into "stable" I suppose?

Yes, if possible.

> What "stable" series we need them to go into?

Braswell support was added in v3.17 so I think from v3.17 onwards.
