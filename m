From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: new Linux/ACPI home page
Date: Thu, 25 Oct 2007 20:49:16 +0100
Message-ID: <1193341756.26901.16.camel@pcjc2lap>
References: <200710251507.56335.lenb@kernel.org>
	 <4720ED77.6090109@gmail.com>  <200710251629.19006.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:53785 "EHLO
	ppsw-8.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762832AbXJYUt3 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 25 Oct 2007 16:49:29 -0400
In-Reply-To: <200710251629.19006.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Linux-acpi <Linux-acpi@vger.kernel.org>


On Thu, 2007-10-25 at 16:29 -0400, Len Brown wrote:
> On Thursday 25 October 2007 15:24, Alexey Starikovskiy wrote:
> > Len Brown wrote:
> 
> > > and going away), and the DSDT databse -- which I believe
> > > is also somewhat of a historical artifact.
> 
> > DSDT database or better acpidump.out database might be very useful,
> > if could be searched for particular feature -- absence of EC, use of SBS, etc.
> 
> True.
> 
> I don't like the original DSDT database -- it was from an era
> when people thought that it was a good idea to hack a DSDT
> to workaround Linux failures and share the hacked DSDT
> with others.  That was a bad strategy and it should be abandoned.
> DSDT hacking is for Linux debugging only -- Linux should
> always be made to work with an un-modified DSDT.

What about plain _crap_ DSDT's like some (mine at least) from HP where
there are problems which just can't be fixed without bypassing the DSDT
functionality (e.g. lid switches, video extension) and writing a driver
specific to that machine's chipset?

Even then, some of the issues are in SMI, so can't be fixed, but at
least with a hacked DSDT, I can get things mostly working with the new
user space. A BIOS would be the _right_ solution, but as the machine is
old, that isn't going to happen.

> yes, acpidump would be more useful than just the DSDT --
> as we get all kinds of issues with all the tables.
> 
> One problem is that shipping around BIOS images, particularly
> modified ones, is sort of a touchy area.  This is the code
> of the manufacturer, who may or may not be happy that the
> community is hacking their code.  If any of those manufactureres
> got mad at Intel for mucking with their BIOS code,
> that would be a bad day for we Intel employees.

Aren't most of the BIOS codes based on reference implementations from
chipset vendors anyway? If so, I think Intel take the lead here and make
their reference BIOS code available publicly. It could be debugged by
the community at large, and perhaps we'd end up with derivative works
(OEM BIOS) of better quality.

Climbing down from the soap box now.

Best wishes

Peter

(who'd reverse engineer and patch his HP BIOS if only he had the
assembler-fu to do so).

-- 
Peter Clifton

Electrical Engineering Division,
Engineering Department,
University of Cambridge,
9, JJ Thomson Avenue,
Cambridge
CB3 0FA

Tel: +44 (0)7729 980173 - (No signal in the lab!)

