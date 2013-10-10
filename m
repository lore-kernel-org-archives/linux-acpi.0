From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: fix UART Auto Flow Control
Date: Thu, 10 Oct 2013 09:31:16 +0300
Message-ID: <20131010063116.GA4140@xps8300>
References: <1381301360-5156-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1942289.aOn1qVrO7l@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1141 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab3JJGbU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Oct 2013 02:31:20 -0400
Content-Disposition: inline
In-Reply-To: <1942289.aOn1qVrO7l@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: chiau.ee.chew@intel.com, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, Oct 09, 2013 at 03:51:44PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, October 09, 2013 09:49:20 AM Heikki Krogerus wrote:
> > There is an additional bit in the GENERAL register on newer
> > silicon that needs to be set or UART's RTS pin fails to
> > reflect the flow control settings in the Modem Control
> > Register.
> > 
> > This will fix an issue where the RTS pin of the UART stays
> > always at 1.8V, regardless of the register settings.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> OK, is this urgent?

No, we can wait for v3.13 if that is what you mean.

> Rafael
> 
> 

-- 
heikki
