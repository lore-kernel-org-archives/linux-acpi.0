From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 13:46:42 -0700
Message-ID: <200706211346.43198.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0706211424170.14859-100000@iolanthe.rowland.org> <200706211251.52952.david-b@pacbell.net> <200706212235.23947.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:20183 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755069AbXFUUqm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 16:46:42 -0400
In-Reply-To: <200706212235.23947.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>

On Thursday 21 June 2007, Rafael J. Wysocki wrote:

> All of this is fine, but we need some way to tell ACPI what the next sleep
> state will be, because currently _we_ _have_ _not_ one.
> 
> So, do we introduce an additional pm_op to do that or are we going to do
> something else?

Simplest would be an additional op.
