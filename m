From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Tue, 2 Apr 2013 20:08:55 +0100
Message-ID: <20130402190855.GA1678@srcf.ucam.org>
References: <20130211190617.GH13768@thinkpad-t410>
 <20130211190914.GA27364@srcf.ucam.org>
 <20130213203228.GE22867@thinkpad-t410>
 <20130213205558.GA16559@srcf.ucam.org>
 <20130307193812.GD24233@thinkpad-t410>
 <20130318212546.GC3964@thinkpad-t410>
 <515A6A10.70404@bjencks.net>
 <515AA197.7020601@intel.com>
 <20130402112328.GA23248@srcf.ucam.org>
 <515AE0A7.2070707@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40345 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761489Ab3DBTJI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 15:09:08 -0400
Content-Disposition: inline
In-Reply-To: <515AE0A7.2070707@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Ben Jencks <ben@bjencks.net>, Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>

On Tue, Apr 02, 2013 at 09:44:07PM +0800, Aaron Lu wrote:
> On 04/02/2013 07:23 PM, Matthew Garrett wrote:
> > On Tue, Apr 02, 2013 at 05:15:03PM +0800, Aaron Lu wrote:
> > 
> >> Perhaps we can introduce a _BCM quirk function, with a DMI table for
> >> these systems.
> > 
> > No. Really, plesae no.
> > 
> 
> I would like to know why, care to explain?

Because Lenovo release another machine with the same behavour and it's 
broken until someone notices and files a bug and gets it added to a 
list. DMI blacklisting is almost always the wrong answer.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
