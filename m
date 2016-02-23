From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI SPI slave device
Date: Tue, 23 Feb 2016 17:32:40 +0200
Message-ID: <20160223153240.GM1770@lahna.fi.intel.com>
References: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
 <20160223073819.GK1770@lahna.fi.intel.com>
 <CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
 <20160223150222.GL1770@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15708 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbcBWPcn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Feb 2016 10:32:43 -0500
Content-Disposition: inline
In-Reply-To: <20160223150222.GL1770@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Leif Liddy <leif.linux@gmail.com>
Cc: linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

On Tue, Feb 23, 2016 at 05:02:22PM +0200, Mika Westerberg wrote:
> > Upstream-status: Inappropriate, real fix forthcoming"
> 
> I believe passing the ACPI handle to the platform device is the real
> fix.

That said, I remember discussing this with Ismo (author of the patch you
are trying out) and the real fix probably means that we do the same for
SPI that we already did for I2C - scan all devices for SpiSerialBus()
connections to the SPI master we just registered, not just the immediate
children.
