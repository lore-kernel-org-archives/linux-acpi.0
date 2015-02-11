From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 00:33:18 +0000
Message-ID: <20150211003318.GA13680@srcf.ucam.org>
References: <1790277.SYbcblnshn@vostro.rjw.lan>
 <20150211002601.GA13363@srcf.ucam.org>
 <1721194.3W9qJruT3Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41426 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbBKAdU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:33:20 -0500
Content-Disposition: inline
In-Reply-To: <1721194.3W9qJruT3Q@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com

On Wed, Feb 11, 2015 at 01:53:26AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 11, 2015 12:26:02 AM Matthew Garrett wrote:
> > Hm. It's not clear to me what the bug is describing. If we're not waking 
> > up more frequently, why aren't we entering PC6?
> 
> Good question. :-)
> 
> The bug is saying, pretty much, that after a positive _OSI response to "Darwin"
> we cannot enter PC6 any more on that machine all other things being equal.

We're using intel_idle, so we should be making idle state determination 
regardless of what ACPI tells us. So is Darwin mode influencing the 
state of some MSR that controls whether PC6 can be entered? Is the GPU 
blocking it because of some configuration difference? I don't know 
enough about how the chip decides to enter PC6 to be able to tell.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
