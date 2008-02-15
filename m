From: Greg KH <gregkh@suse.de>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Fri, 15 Feb 2008 12:58:02 -0800
Message-ID: <20080215205802.GA7583@suse.de>
References: <200802111623.38478.elendil@planet.nl> <86802c440802141538m44d64b6as827426174874979d@mail.gmail.com> <20080215065746.GA8916@suse.de> <200802151119.23325.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:55486 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398AbYBOVFA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 16:05:00 -0500
Content-Disposition: inline
In-Reply-To: <200802151119.23325.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Feb 15, 2008 at 11:19:20AM +0100, Frans Pop wrote:
> On Friday 15 February 2008, Greg KH wrote:
> > I swear someone sent this patch in before.  Can you try this one below,
> > there seems to be an imbalance with kobject_get and _put.
> 
> I did remember seeing this patch before [1] and can confirm that it does 
> indeed fix the issue: with this patch applied to 2.6.25 git head my system 
> powers off correctly.
> 
> [1] See http://lkml.org/lkml/2008/2/8/342; also added to #9960.

Ah, thanks, for some reason I couldn't find this in my archives.

I'll add this to my queue to go to Linus.

thanks,

greg k-h
