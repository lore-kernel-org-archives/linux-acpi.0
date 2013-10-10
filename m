From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: fix UART Auto Flow Control
Date: Thu, 10 Oct 2013 15:04:57 +0200
Message-ID: <2195301.dtlS3cFnEd@vostro.rjw.lan>
References: <1381301360-5156-1-git-send-email-heikki.krogerus@linux.intel.com> <1942289.aOn1qVrO7l@vostro.rjw.lan> <20131010063116.GA4140@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63417 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752326Ab3JJMxO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2013 08:53:14 -0400
In-Reply-To: <20131010063116.GA4140@xps8300>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: chiau.ee.chew@intel.com, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thursday, October 10, 2013 09:31:16 AM Heikki Krogerus wrote:
> On Wed, Oct 09, 2013 at 03:51:44PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, October 09, 2013 09:49:20 AM Heikki Krogerus wrote:
> > > There is an additional bit in the GENERAL register on newer
> > > silicon that needs to be set or UART's RTS pin fails to
> > > reflect the flow control settings in the Modem Control
> > > Register.
> > > 
> > > This will fix an issue where the RTS pin of the UART stays
> > > always at 1.8V, regardless of the register settings.
> > > 
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > OK, is this urgent?
> 
> No, we can wait for v3.13 if that is what you mean.

OK

