From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Driver for handling SCI interrupt.
Date: Mon, 6 Feb 2012 14:57:59 +0000
Message-ID: <20120206145759.GA29805@srcf.ucam.org>
References: <CADVYk4RTY3=Xiw5JsiDssN9i3yo+jQw1p_i42tKrMDVH5=_ykQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59700 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab2BFO6E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2012 09:58:04 -0500
Content-Disposition: inline
In-Reply-To: <CADVYk4RTY3=Xiw5JsiDssN9i3yo+jQw1p_i42tKrMDVH5=_ykQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Toussaint <daniel@dmhome.net>
Cc: linux-acpi@vger.kernel.org

On Mon, Feb 06, 2012 at 11:25:20AM +0800, Daniel Toussaint wrote:

> I am working on an Intel (ICH8) based system. A custom device on the system
> emits interrupts to a GPI on the ICH8 chip. Currently, as a test, I have
> from userspace configured the GPI we use to send a SCI. This seems to work,
> because I get a "IRQ9 , nobody cared" message from the kernel.
> My questions now are :
> How do I go about and create an ACPI based driver to catch this event ? Or am
> I searching in the wrong direction.
> If I am right, and the driver has to go through ACPI, are changes to the
> ACPI tables in BIOS required ?

The ACPI tables should declare the device and its resources, along with 
a unique _HID() to allow the driver to bind to it. There should also be 
a _Lxx or_Exx (depending on whether it's level or edge triggered) method 
for the appropriate GPE (which is the GPIO number + 0x10 on ICH8, I 
believe) which sends a Notify to the ACPI device. It's then trivial to 
write a small Linux acpi driver which will get the notifications.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
