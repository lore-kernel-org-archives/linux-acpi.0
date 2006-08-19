From: Thomas Renninger <trenn@suse.de>
Subject: Re: DSDT/ASL compiler error
Date: Sat, 19 Aug 2006 14:50:12 +0200
Message-ID: <1155991812.4302.1357.camel@queen.suse.de>
References: <20060817170303.GA3592@cactii.net>
	 <1155897211.4302.1318.camel@queen.suse.de>
	 <20060818112517.GB4945@poupinou.org>
	 <1155906597.4302.1339.camel@queen.suse.de>
	 <20060818201858.GD4945@poupinou.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:38559 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751738AbWHSMpN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Aug 2006 08:45:13 -0400
In-Reply-To: <20060818201858.GD4945@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Ben B <kernel@bb.cactii.net>, linux-acpi@vger.kernel.org

On Fri, 2006-08-18 at 22:18 +0200, Bruno Ducrot wrote:
> On Fri, Aug 18, 2006 at 03:09:56PM +0200, Thomas Renninger wrote:
> > (unfortunately, I hoped that was the missing hint to fix some things on
> > this system).
> 
> What things need to be fixed?  I'm just curious.

- _PPC always returns 1, therefore highest freq cannot be set
  (also reported recently on cpufreq list)
  https://bugzilla.novell.com/show_bug.cgi?id=179702

- The other one could be an EC issue:
  battery and AC status is not updated.
  May be an interference with the mouse driver from the comments,
  no idea yet.
  https://bugzilla.novell.com/show_bug.cgi?id=200169

Any hints are greatly appreciated...
AFAIK both (at least first on several Core Duo models) phenomenons seem
to happen on several (all?) new HP models.

   Thomas

