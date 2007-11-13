From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Tue, 13 Nov 2007 15:01:01 -0700
Message-ID: <200711131501.01320.bjorn.helgaas@hp.com>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113203645.GB22812@ldl.fc.hp.com> <20071113213049.GA4194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel10.hp.com ([156.153.255.245]:55136 "EHLO palrel10.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760699AbXKMWBH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Nov 2007 17:01:07 -0500
In-Reply-To: <20071113213049.GA4194@kroah.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg KH <greg@kroah.com>, Alex Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tuesday 13 November 2007 02:30:49 pm Greg KH wrote:
> On Tue, Nov 13, 2007 at 01:36:45PM -0700, Alex Chiang wrote:
> > * Greg KH <greg@kroah.com>:
> > > IBM sells a program that does this for server rooms.  It's
> > > probably part of some Tivoli package somewhere, sorry I don't
> > > remember the name.  I did see it working many years ago and it
> > > required no kernel changes at all to work properly.

Do you know how this Tivoli package works or where it gets the
information?

> > Like I said in an earlier email, HP ia64 systems will require a
> > kernel change to get this information. Whether it comes via a
> > generic ACPI access layer like dev_acpi, or something like this
> > patch series, the kernel will still get touched.
> 
> And like I said, I'm pretty sure you don't need to touch the kernel
> today as there are people doing this just fine from userspace without
> any kernel changes needed :)

I think you are assuming userspace can just dump the raw ACPI tables
and extract this information from them.  But I don't think that's
possible because _SUN is a method that can contain arbitrary AML.
That AML has to be *executed*, and you can't do that safely in
userspace.

Bjorn
