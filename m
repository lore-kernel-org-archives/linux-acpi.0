From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Fri, 13 Apr 2007 14:59:45 -0600
Message-ID: <200704131459.45867.bjorn.helgaas@hp.com>
References: <45D5EA88.7090300@redhat.com> <200704131218.44045.bjorn.helgaas@hp.com> <20070413200746.GD28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:52664 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030297AbXDMU74 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Apr 2007 16:59:56 -0400
In-Reply-To: <20070413200746.GD28264@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jean Delvare <khali@linux-fr.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Friday 13 April 2007 14:07, Pavel Machek wrote:
> > > ... The primary issue is the concurrent access
> > > to resources, which cause lots of trouble which are hard to investigate.
> > > If ACPI reserves the ports, then the SMBus or hardware monitoring
> > > drivers (or any other conflicting driver) will cleanly fail to load,
> > > which would be a move in the right direction. ...
> > > 
> > > So, can ACPI actually reserve the ports it accesses?
> > 
> > Sorry to join this discussion so late.
> > 
> > ACPI tells us the resources used by devices.  Today, we don't
> > reserve
> 
> Problem seems to be that ACPI does _not_ tell us which ports it
> accesses from AML code.

I think that would violate at least the spirit of the ACPI spec.
The example in section 11.6 of the ACPI 3.0 spec shows a _TMP
method that runs an EC method to read the temp, and the EC ioport
usage is correctly declared in the EC device's _CRS method.

Of course, there are always BIOS defects.  But if we could make a
case that a BIOS that doesn't declare the resources used by the AML
is defective, we could add quirks to reserve the undeclared resources.

Chuck's last update (http://lkml.org/lkml/2007/2/20/136) says his
problem turned out to be unrelated to k8temp and may have gone away
after a BIOS update.

> But we already found a lock we can take; AFAICT we know how to solve
> this problem.

This might solve it, but doesn't seem like a clean way to do it.
I don't like the idea of sharing a lock between drivers and ACPI.
k8temp happens to be x86-dependent, so we'll always have ACPI, but
in principle, we could have the same problem with an arch-independent
PCI driver that only has ACPI on x86 and ia64 platforms.

(BTW, if Chuck's problem was solved by the BIOS update, I assume
there *is* another instance of the problem that we're trying to
solve with this lock.)

Bjorn
