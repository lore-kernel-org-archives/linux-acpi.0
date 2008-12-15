From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Mon, 15 Dec 2008 21:19:34 +0100
Message-ID: <200812152119.35228.rjw@sisk.pl>
References: <gi247o$iog$1@ger.gmane.org> <494694F8.6080004@gmail.com> <gi65ol$bnf$7@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49757 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059AbYLOUUG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Dec 2008 15:20:06 -0500
In-Reply-To: <gi65ol$bnf$7@ger.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, 15 of December 2008, Brian J. Murrell wrote:
> On Mon, 15 Dec 2008 20:33:44 +0300, Alexey Starikovskiy wrote:
> 
> >> video                  25360  0
> >>   
> > this one ^^^^^
> 
> Ahhh.  Got it.
> 
> Unfortunately that was of no help.  Still only a single suspend/resume 
> cycle worked.  I removed it before the first cycle, (and made sure it was 
> not loaded before the second) for the record.

Does it also happen in the minimal configuration (ie. with init=/bin/bash)?

Rafael
