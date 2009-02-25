From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Wed, 25 Feb 2009 17:53:39 +0000
Message-ID: <1235584419.4770.86.camel@penguin.lifesci.dundee.ac.uk>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
	 <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225172835.GA7152@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lifesci.dundee.ac.uk ([134.36.67.240]:58196 "EHLO
	frigg.compbio.dundee.ac.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755168AbZBYRxt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Feb 2009 12:53:49 -0500
In-Reply-To: <20090225172835.GA7152@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net


On Wed, 2009-02-25 at 17:28 +0000, Matthew Garrett wrote:
> On Wed, Feb 25, 2009 at 05:12:58PM +0000, Jonathan Buzzard wrote:
> 
> > Surely a consistent abstraction of the HCI interface with a user mode
> > program to tickle that interface as necessary is better than adding
> > hundreds of lines of code to the kernel, and having to constantly update
> > the driver when new models come out?
> 
> The same argument encourages us to put rfkill and brightness control 
> support in a userland tool, despite the existing kernel interfaces for 
> controlling them. We could replace almost every driver in platform/x86 
> with a generic driver that allowed arbitrary ACPI methods to be called 
> and gave access to EC bits. The reason we haven't done this is because 
> that's what the kernel is there for.

Quite correct they should be removed. The first step of which is to
provide a generic interface to the HCI.

> > On top of that this is the way it has been done now for over a decade.
> > The patch enables modern ACPI laptops to use the existing tools for
> > Toshiba laptops, without having to compile your own out of band kernel
> > module. It is unlikely that someone is going to write and debug the
> > kernel code to move the likes of toshset into kernel space in the first
> > place and keep it up to date in the second.
> 
> The effort required to maintain toshset is identical to the effort 
> required to maintain the kernel-level driver. Porting this functionality 
> isn't difficult.
> 

You do it, test it then maintain it then. To claim that maintaining this
in kernel space is as easy as users space is patently ludicrous.

It also makes it harder for end users, because it means that you need a
new kernel for new functionality. My new laptop is not supported by
distro X, rather than grab a user mode program I have to fiddle with
patching a kernel and keeping it up to date.

Lot of drivers are user space, for example almost all USB scanner
drivers are user space.

> Please don't add an interface that exists purely in order to avoid 
> writing a proper kernel driver.
> 

A "proper" kernel driver as you put it is is completely inappropriate.
You want to unnecessarily pollute the kernel with hundreds of lines of
code for no actual gain in functionality.


JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.

