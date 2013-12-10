From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / blacklist: disable Win8 mode for ThinkPad X201
 and Latitude E6230
Date: Tue, 10 Dec 2013 17:01:24 +0000
Message-ID: <20131210170124.GA26978@srcf.ucam.org>
References: <52A15F72.1050408@intel.com>
 <20131209165817.GA30717@srcf.ucam.org>
 <52A684F1.7070502@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36204 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab3LJRBd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2013 12:01:33 -0500
Content-Disposition: inline
In-Reply-To: <52A684F1.7070502@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jeffery To <jeffery.to@gmail.com>, Wouter Depypere <wouter.depypere@ugent.be>

On Tue, Dec 10, 2013 at 11:05:21AM +0800, Aaron Lu wrote:
> On 12/10/2013 12:58 AM, Matthew Garrett wrote:
> > On Fri, Dec 06, 2013 at 01:24:02PM +0800, Aaron Lu wrote:
> >>  	/*
> >> +	 * The bluetooth functionality is unconditionally enabled
> >> +	 * after a S3 cycle on Thinkpad X201 under Win8 mode.
> >> +	 */
> > 
> > Can you describe this in a little more detail? Does the thinkpad-acpi 
> > rfkill code just not work?
> 
> Yes it works, the problem is, even the bluetooth is disabled before
> hibernate, it will be enabled after resume.

Ok. thinkpad_acpi should be ensuring that the state is the same before 
and after resume. I don't think it's worth working around this in the 
core.

> >> +	/*
> >> +	 * The hardware switch for enable/disable wifi on
> >> +	 * Dell Latitude E6230 is broken under Win8 mode.
> >> +	 */
> > 
> > Can you define "broken"? Do you see the same behaviour under Windows 8?
> 
> As Wouter has put in comment #12:
> "
> I also have trouble with this commit, it disables my hardware switch for
> enable/disable wifi. See [1] for full explanation.
> 
> When I add acpi_osi="!Windows 2012" it fixes my issue.
> "

I'd like to be able to dig into this rather than just going straight to 
blacklisting.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
