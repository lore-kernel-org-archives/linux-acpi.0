From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Don't abort acpi scan on missing mem
 resource.
Date: Tue, 8 Aug 2017 13:13:06 +0300
Message-ID: <20170808101306.GK2369@lahna.fi.intel.com>
References: <1501890376-2662-1-git-send-email-ronald@innovation.ch>
 <20170807104709.GU2369@lahna.fi.intel.com>
 <20170808031416.GB9396@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1506 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbdHHKVw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Aug 2017 06:21:52 -0400
Content-Disposition: inline
In-Reply-To: <20170808031416.GB9396@innovation.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Federico Lorenzi <florenzi@gmail.com>, linux-acpi@vger.kernel.org

On Mon, Aug 07, 2017 at 08:14:16PM -0700, Life is hard, and then you die wrote:
> 
> On Mon, Aug 07, 2017 at 01:47:09PM +0300, Mika Westerberg wrote:
> > On Fri, Aug 04, 2017 at 04:46:16PM -0700, Ronald Tschalär wrote:
> > > On MacBook8's (2015) there appears to be no memory resource for the
> > > SPI master device. Returning an error here in this case then leads to
> > > the acpi device being ignored completely instead of just the handler
> > > being skipped.
> > 
> > What's the problem if we prevent creation of the SPI master device? How
> > does user see the issue?
> 
> Their keyboard and touchpad don't work :-)
> 
> > It is not like the SPI driver could use the
> > device anyway.
> 
> The spi master device works just fine (once recognized). Nothing the
> acpi-lpss handler provides appears to be necessary for this device
> (though admittedly the PM stuff hasn't been explored much).
> 
> > Just trying to understand why we would want to change the behaviour.
> 
> Apologies for the lack of context. This is related to the work on
> the SPI keyboard and touchpad driver for MacBook(Pro)'s
> (https://github.com/cb22/macbook12-spi-driver/) (and as such is
> tangentally related to the recent apple SPI properties work by Lukas
> Wunner that just got accepted). We obviously need the spi master
> device in order to set up the keyboard/touchpad SPI slave device.

OK, thanks for the clarification. I think it may be good idea to add
these details to the changelog as well.

The patch itself is fine by me :)
