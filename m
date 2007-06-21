From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 23:02:51 +0200
Message-ID: <200706212302.52737.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706211424170.14859-100000@iolanthe.rowland.org> <200706212235.23947.rjw@sisk.pl> <200706211346.43198.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54078 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464AbXFUU4G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 16:56:06 -0400
In-Reply-To: <200706211346.43198.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>

On Thursday, 21 June 2007 22:46, David Brownell wrote:
> On Thursday 21 June 2007, Rafael J. Wysocki wrote:
> 
> > All of this is fine, but we need some way to tell ACPI what the next sleep
> > state will be, because currently _we_ _have_ _not_ one.
> > 
> > So, do we introduce an additional pm_op to do that or are we going to do
> > something else?
> 
> Simplest would be an additional op.

OK

Does anyone have any objections to adding a new pm_op that will tell
the ACPI core (or generally, a platform core code) what target system sleep
state we are going to enter?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
