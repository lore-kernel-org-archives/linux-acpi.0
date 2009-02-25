From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: experimental patch for toshiba_acpi
Date: Wed, 25 Feb 2009 17:28:35 +0000
Message-ID: <20090225172835.GA7152@srcf.ucam.org>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52416 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbZBYR2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 12:28:41 -0500
Content-Disposition: inline
In-Reply-To: <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Buzzard <jonathan@buzzard.me.uk>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net

On Wed, Feb 25, 2009 at 05:12:58PM +0000, Jonathan Buzzard wrote:

> Surely a consistent abstraction of the HCI interface with a user mode
> program to tickle that interface as necessary is better than adding
> hundreds of lines of code to the kernel, and having to constantly update
> the driver when new models come out?

The same argument encourages us to put rfkill and brightness control 
support in a userland tool, despite the existing kernel interfaces for 
controlling them. We could replace almost every driver in platform/x86 
with a generic driver that allowed arbitrary ACPI methods to be called 
and gave access to EC bits. The reason we haven't done this is because 
that's what the kernel is there for.

> On top of that this is the way it has been done now for over a decade.
> The patch enables modern ACPI laptops to use the existing tools for
> Toshiba laptops, without having to compile your own out of band kernel
> module. It is unlikely that someone is going to write and debug the
> kernel code to move the likes of toshset into kernel space in the first
> place and keep it up to date in the second.

The effort required to maintain toshset is identical to the effort 
required to maintain the kernel-level driver. Porting this functionality 
isn't difficult.

Please don't add an interface that exists purely in order to avoid 
writing a proper kernel driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
