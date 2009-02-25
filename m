From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Wed, 25 Feb 2009 17:12:58 +0000
Message-ID: <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lifesci.dundee.ac.uk ([134.36.67.240]:65287 "EHLO
	frigg.compbio.dundee.ac.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759620AbZBYRNI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Feb 2009 12:13:08 -0500
In-Reply-To: <20090225165152.GA5981@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net


On Wed, 2009-02-25 at 16:51 +0000, Matthew Garrett wrote:
> On Wed, Feb 25, 2009 at 04:18:25PM +0000, Jonathan Buzzard wrote:
> 
> > Because it makes far more sense to have a user mode program to drive the
> > features, and for the kernel to provide the necessary thin layer to
> > access the features.
> 
> It makes sense for the kernel to provide a consistent abstraction of 
> hardware functionality where possible. Almost every kernel driver could 
> be rewritten in userspace - that doesn't make it a good idea.
>

The driver *does* provide a consistent abstraction of the Toshiba
Hardware Configuration Interface (HCI) on an ACPI enabled "pucker"
Toshiba laptop, that is a laptop designed and manufactured by Toshiba
and not OEM'ed.

That patch causes the toshiba_acpi driver to provide the same
abstraction of the HCI that the toshiba driver provides for "pucker"
Toshiba laptops with APM and has been doing so for over a decade now.

The HCI interface has existed on "pucker" Toshiba laptops for a very
long time, nearly 20 years now. The calls that are valid in the HCI are
specific to the model in question.

Surely a consistent abstraction of the HCI interface with a user mode
program to tickle that interface as necessary is better than adding
hundreds of lines of code to the kernel, and having to constantly update
the driver when new models come out?

On top of that this is the way it has been done now for over a decade.
The patch enables modern ACPI laptops to use the existing tools for
Toshiba laptops, without having to compile your own out of band kernel
module. It is unlikely that someone is going to write and debug the
kernel code to move the likes of toshset into kernel space in the first
place and keep it up to date in the second.


JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.

