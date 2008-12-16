From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Tue, 16 Dec 2008 16:37:46 +0000
Message-ID: <20081216163746.GA9478@srcf.ucam.org>
References: <gi247o$iog$1@ger.gmane.org> <200812161625.37318.rjw@sisk.pl> <gi8jf1$m5f$5@ger.gmane.org> <200812161713.08451.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40076 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbYLPQiD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 11:38:03 -0500
Content-Disposition: inline
In-Reply-To: <200812161713.08451.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Dec 16, 2008 at 05:13:08PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, 16 of December 2008, Brian J. Murrell wrote:
> > On Tue, 16 Dec 2008 16:25:37 +0100, Rafael J. Wysocki wrote:
> > 
> > > Because the hal-driven whitelist allows us to match systems in a more
> > > detailed way.  If your system is in the s2ram whitelist already and
> > > works with it, there shouldn't be any difference.
> > 
> > Unfortunately, Ubuntu in their "wisdom" removed s2ram and claim "s2both" 
> > supersedes it in that it does both suspend to disk and suspend to ram and 
> > then suspends, but if your battery dies while suspended you can still 
> > resume from the suspend to disk.

I seem to be missing the original message, but: no, s2ram doesn't exist 
in Ubuntu because pm-utils handles that role.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
