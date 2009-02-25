From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: experimental patch for toshiba_acpi
Date: Wed, 25 Feb 2009 17:59:23 +0000
Message-ID: <20090225175923.GB7836@srcf.ucam.org>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk> <20090225172835.GA7152@srcf.ucam.org> <1235584419.4770.86.camel@penguin.lifesci.dundee.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:32828 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZBYR72 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 12:59:28 -0500
Content-Disposition: inline
In-Reply-To: <1235584419.4770.86.camel@penguin.lifesci.dundee.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Buzzard <jonathan@buzzard.me.uk>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net

On Wed, Feb 25, 2009 at 05:53:39PM +0000, Jonathan Buzzard wrote:
> 
> On Wed, 2009-02-25 at 17:28 +0000, Matthew Garrett wrote:
> > The same argument encourages us to put rfkill and brightness control 
> > support in a userland tool, despite the existing kernel interfaces for 
> > controlling them. We could replace almost every driver in platform/x86 
> > with a generic driver that allowed arbitrary ACPI methods to be called 
> > and gave access to EC bits. The reason we haven't done this is because 
> > that's what the kernel is there for.
> 
> Quite correct they should be removed. The first step of which is to
> provide a generic interface to the HCI.

Yeah. No.

> You do it, test it then maintain it then. To claim that maintaining this
> in kernel space is as easy as users space is patently ludicrous.

How so? C is C. Whether you do it in userspace or kernel space, all you 
have to do is make a function call with the appropriate arguments.

> A "proper" kernel driver as you put it is is completely inappropriate.
> You want to unnecessarily pollute the kernel with hundreds of lines of
> code for no actual gain in functionality.

Yes. I want a proper kernel driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
