From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup and fixes
Date: Sat, 22 Mar 2008 11:29:34 -0700
Message-ID: <200803221129.34982.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org> <200803221055.12541.david-b@pacbell.net> <200803221911.01670.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:34580 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756779AbYCVS3h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Mar 2008 14:29:37 -0400
In-Reply-To: <200803221911.01670.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Saturday 22 March 2008, Rafael J. Wysocki wrote:
> 
> > It seems to me that your objection boils down to the concern
> > that those drivers may just have pushed their bug out a level,
> > rather than actually fixing their bugs.
> 
> Or, the authors of the drivers looked at what the code in
> pci_choose_state() actually did and used it on that basis.

That sounds like *exactly* the same thing.


