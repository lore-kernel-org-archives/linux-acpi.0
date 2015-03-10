From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: provide con_id for the clkdev
Date: Tue, 10 Mar 2015 09:28:48 +0200
Message-ID: <20150310072848.GB25137@kuha.fi.intel.com>
References: <1425649718-138462-1-git-send-email-heikki.krogerus@linux.intel.com>
 <3532353.A5zUUUFAVv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6694 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbbCJHa7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2015 03:30:59 -0400
Content-Disposition: inline
In-Reply-To: <3532353.A5zUUUFAVv@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Mon, Mar 09, 2015 at 04:22:30PM +0100, Rafael J. Wysocki wrote:
> On Friday, March 06, 2015 03:48:38 PM Heikki Krogerus wrote:
> > Commit 7d78cbefaa (serial: 8250_dw: add ability to handle
> > the peripheral clock) introduces handling for a second clk
> > to 8250_dw.c which is the driver also for LPSS UART. The
> > second clk forces us to provide identifier (con_id) for the
> > clkdev we create.
> > 
> > This fixes an issue where 8250_dw.c is getting the same
> > handler for both clocks.
> > 
> > Fixes: 7d78cbefaa (serial: 8250_dw: add ability to handle the peripheral clock)
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> "Stable" material I suppose?  3.17 and later or some other set?

Yes, I should have put the tag there. And yes, 3.17 and later.


Thanks,

-- 
heikki
