From: "Paul B. Henson" <henson@acm.org>
Subject: Re: Broken suspend to RAM on Asus P8P67-M motherboard (bad BIOS?)
Date: Fri, 13 Jan 2012 16:11:13 -0800
Message-ID: <20120114001113.GY4844@bender.csupomona.edu>
References: <20111228231919.GI8711@bender.csupomona.edu>
 <201112290055.04384.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ironport02-1.csupomona.edu ([134.71.187.45]:64997 "EHLO
	ironport02-1.csupomona.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751912Ab2ANALO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jan 2012 19:11:14 -0500
Content-Disposition: inline
In-Reply-To: <201112290055.04384.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

> On Thursday, December 29, 2011, Paul B. Henson wrote:
> > I have an Asus P8P67-M Pro motherboard which fails to suspend to ram
> > under Linux yet suspends successfully under Windows 7.
[...]
> > While working on the issue, I noticed the following suspicious ACPI
> > errors logged when doing a core test of STR:
> > 
> > Dec 28 14:28:41 htpc-lr kernel: ACPI: Preparing to enter system sleep
> > state S3
> > Dec 28 14:28:41 htpc-lr kernel: ACPI Error: [RAMB] Namespace lookup
> > failure, AE_NOT_FOUND (20110623/psargs-359)
> > Dec 28 14:28:41 htpc-lr kernel: ACPI Error: Method parse/execution
> > failed [\_PTS] (Node ffff88011e8a3a38), AE_NOT_FOUND
> > (20110623/psparse-536)

Another user I was corresponding with found this patch:

http://thread.gmane.org/gmane.linux.acpi.devel/51405/focus=51407

I haven't tested it yet myself, but he said after applying that whole
patchset his Asus motherboard suspended perfectly under linux, so it
looks like the root cause of the failure was the linux acpi code, not a
broken Asus BIOS (although their Linux support still sucks :( ).

Any idea when that patchset might show up in a release kernel, and
whether or not it might be backported to a LTS kernel as included in
most distributions?

Thanks...

-- 
Paul B. Henson  |  (909) 979-6361  |  http://www.csupomona.edu/~henson/
Operating Systems and Network Analyst  |  henson@csupomona.edu
California State Polytechnic University  |  Pomona CA 91768
