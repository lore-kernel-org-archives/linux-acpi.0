From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 00:42:12 +0000
Message-ID: <20150211004212.GA14030@srcf.ucam.org>
References: <1790277.SYbcblnshn@vostro.rjw.lan>
 <1721194.3W9qJruT3Q@vostro.rjw.lan>
 <20150211003318.GA13680@srcf.ucam.org>
 <3544719.NIea3H3XJ4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41484 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbBKAmS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:42:18 -0500
Content-Disposition: inline
In-Reply-To: <3544719.NIea3H3XJ4@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com, Len Brown <len.brown@intel.com>

On Wed, Feb 11, 2015 at 02:02:06AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 11, 2015 12:33:18 AM Matthew Garrett wrote:
> > We're using intel_idle, so we should be making idle state determination 
> > regardless of what ACPI tells us. So is Darwin mode influencing the 
> > state of some MSR that controls whether PC6 can be entered?
> 
> I need to confirm that with Len, but I don't recall there being an MSR
> controlling the PC6 availability on Haswell.  There is one for PC7, but
> not for PC6 IIRC.

Ok.

> > Is the GPU blocking it because of some configuration difference?
> 
> That is possible.

I know that it has some say in things here.

> > I don't know enough about how the chip decides to enter PC6 to be able to
> > tell.
> 
> Well, so honestly how do you expect me to respond here?

We really need feedback from people who know how the CPU makes its PC6 
determination - the firmware has clearly done something differently, but 
without knowing what factors feed into that determination we're pretty 
much helpless.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
