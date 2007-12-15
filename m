From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: No battery status with 2.6.24-rcX anymore
Date: Sun, 16 Dec 2007 00:30:08 +0100
Message-ID: <200712160030.08991.rjw@sisk.pl>
References: <4762C081.4010000@willies.info> <200712141504.41707.lenb@kernel.org> <476408D2.1060205@willies.info>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45820 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267AbXLOXKz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Dec 2007 18:10:55 -0500
In-Reply-To: <476408D2.1060205@willies.info>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Willies <jan@willies.info>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Saturday, 15 of December 2007, Jan Willies wrote:
> Len Brown wrote:
> > On Friday 14 December 2007 12:42, Jan Willies wrote:
> > 
> >> ACPI: Table DSDT replaced by host OS
> > 
> > Sorry, can't help you if you are running a modified BIOS.
> 
> Uh sorry, I totally forgot about that. It's just some compile errors fixed with intel compiler [1] and a little undervolting [2], don't know if it matters at all. Here is a clean log:
[--snip--]
> What else information is needed?

Have you tested the latest Linus' tree?  We've had some ACPI fixes recently.

Greetings,
Rafael
