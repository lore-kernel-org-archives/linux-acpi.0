From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Why is it so hard to (get) help on ACPI?
Date: Thu, 17 May 2007 23:24:33 +0100
Message-ID: <20070517222432.GA25402@srcf.ucam.org>
References: <200705172005.47845.matija.suklje@rutka.net> <200705172132.06026.matija.suklje@rutka.net> <8f8ff01d0705171256m39b6e5t8a69f8095f00594b@mail.gmail.com> <200705172210.14815.matija.suklje@rutka.net> <20070517204439.GA23599@srcf.ucam.org> <464CD43E.8060409@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:38728 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757484AbXEQWYl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 May 2007 18:24:41 -0400
Content-Disposition: inline
In-Reply-To: <464CD43E.8060409@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Engel <j-engel@gmx.de>
Cc: Matija =?iso-8859-15?Q?=A6uklje?= <matija.suklje@rutka.net>, Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org

On Fri, May 18, 2007 at 12:16:30AM +0200, Johannes Engel wrote:

> Hm, I do not totally agree. Since in some cases you know that a BIOS
> update caused the trouble it seems to be likely in my eyes that these
> problems could be fixed by DSDT changes. Please correct me if I'm wrong.

The DSDT is far from the only bit of the BIOS used during 
suspend/resume. When you wake up, the system jumps back into the BIOS. 
An arbitrarily large amount of code can be executed there before control 
is passed back to the kernel. That's likely to be much more significant.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
