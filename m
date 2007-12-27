From: Thomas Jaeger <thjaeger@gmail.com>
Subject: interrupt resource descriptor issues
Date: Thu, 27 Dec 2007 02:23:24 +0100
Message-ID: <4772FE8C.3080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:50054 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbXL0BXu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 20:23:50 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1558790fga.17
        for <linux-acpi@vger.kernel.org>; Wed, 26 Dec 2007 17:23:49 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I recently filed bug 9487
(http://bugzilla.kernel.org/show_bug.cgi?id=9487 ), which prevents the
pen on most, if not all, Toshiba Tablet PCs from waking up from suspend
mode.  I don't think the bug was announced on this list since I
originally filed it in the wrong category.
Anyway, I investigated the issue further and here is what happens as far
as I can tell:
During boot, _CRS is called and the returned buffer is converted into
the kernel's own format.  This is not a one-to-one mapping.
Specifically, the ACPI spec allows high true, edge sensitive,
non-shareable interrupts to be represented by 3-byte descriptors, but
4-byte descriptors that set the appropriate flags are also possible,
which is what these Tablet PCs choose to do for their serial port.  Upon
resume, _SRS is called, so the internal representation needs to be
converted back to an AML buffer, but at this point the information how
the original buffer looked like is lost.  In my case, the kernel chooses
a three-byte descriptor that evidently throws off the device's firmware,
which expects the buffer to be in the same format as returned by _CRS.
Of course, this is not technically a kernel bug because the buffer
passed to _SRS complies with the ACPI standard, but I think this sort of
problem is fairly common.  The other instance I'm aware of actually goes
in the opposite direction:  The The Fujitsu Lifebook C1020's parallel
port returns a three-byte descriptor and appears to require a three-byte
descriptor to be passed to _SRS in order to wake up (see
http://bugzilla.kernel.org/show_bug.cgi?id=6316 ).  Presumably Windows
does not alter the form of the buffer, so it's reasonable that linux
should do the same.

I've created a patch that keeps track of whether _CRS returned a three
or four-byte descriptor by adding a new field descriptor_length to
acpi_resource_irq and respects that information during conversion back
to an AML resource.  It's attached to bug 9487.

When I made the changes I stumbled upon the following bugs in rsparser.c
that I took the liberty of correcting, but I'd be happy to separate the
changes into two patches if that's desired:

* decode_irq_flags would leave values uninitialized if additional flags
such as IORESOURCE_IRQ_SHAREABLE were set.
* pnpacpi_encode_irq would deduce sharable from triggering and polarity.
 This may well be okay in practice, but the IORESOURCE_IRQ_SHAREABLE
flag should be used (the same goes for pnpacpi_encode_ext_irq, btw).
* pnpacpi_encode_ext_irq would write to resource->data.irq.sharable
which is actually data.extended_irq.polarity.


Thanks,

Tom


