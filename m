From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: DSDT/ASL compiler error
Date: Sun, 20 Aug 2006 12:09:43 +0200
Message-ID: <20060820100943.GE4945@poupinou.org>
References: <20060817170303.GA3592@cactii.net> <1155897211.4302.1318.camel@queen.suse.de> <20060818112517.GB4945@poupinou.org> <1155906597.4302.1339.camel@queen.suse.de> <20060818201858.GD4945@poupinou.org> <1155991812.4302.1357.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:64532 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1750721AbWHTKJw
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Aug 2006 06:09:52 -0400
Content-Disposition: inline
In-Reply-To: <1155991812.4302.1357.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Ben B <kernel@bb.cactii.net>, linux-acpi@vger.kernel.org

On Sat, Aug 19, 2006 at 02:50:12PM +0200, Thomas Renninger wrote:
> On Fri, 2006-08-18 at 22:18 +0200, Bruno Ducrot wrote:
> > On Fri, Aug 18, 2006 at 03:09:56PM +0200, Thomas Renninger wrote:
> > > (unfortunately, I hoped that was the missing hint to fix some things on
> > > this system).
> > 
> > What things need to be fixed?  I'm just curious.
> 
> - _PPC always returns 1, therefore highest freq cannot be set
>   (also reported recently on cpufreq list)
>   https://bugzilla.novell.com/show_bug.cgi?id=179702
> 
> - The other one could be an EC issue:
>   battery and AC status is not updated.
>   May be an interference with the mouse driver from the comments,
>   no idea yet.
>   https://bugzilla.novell.com/show_bug.cgi?id=200169
> 
> Any hints are greatly appreciated...
> AFAIK both (at least first on several Core Duo models) phenomenons seem
> to happen on several (all?) new HP models.
> 

My first though is to try atpic instead of apic and maybe tweak
apci_sci= parameter?  I'll look more in details the bug.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
