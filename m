From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Wed, 14 Nov 2007 14:24:11 -0700
Message-ID: <20071114212411.GB6575@ldl.fc.hp.com>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113202632.GA3227@kroah.com> <20071113145936.7e1c58fb.kristen.c.accardi@intel.com> <200711141037.09228.bjorn.helgaas@hp.com> <20071114175317.GB14994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel11.hp.com ([156.153.255.246]:37827 "EHLO palrel11.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754102AbXKNVYN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 16:24:13 -0500
Content-Disposition: inline
In-Reply-To: <20071114175317.GB14994@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-pci@atrey.karlin.mff.cuni.cz, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, gregkh@suse.de, lenb@kernel.org, matthew@wil.cx, rick.jones2@hp.com, linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

Hi Greg,

* Greg KH <greg@kroah.com>:
> On Wed, Nov 14, 2007 at 10:37:08AM -0700, Bjorn Helgaas wrote:
> > 
> > So I agree that the firmware kit has a clever hack that works
> > on much existing x86 firmware, and it sounds like Tivoli
> > might even rely on it.  But I don't feel good about it, and
> > it could easily break when some BIOS writer needs to make
> > _SUN slightly more complicated.
> 
> Do you know of such BIOSes out there that do this?  Will the
> above scheme not work for the ia64 boxes that you know of that
> are out in the world today?

Talked to some of our ia64 firmware folks, and they confirmed
that our future platforms will implement _SUN as a control
method.

Thanks.

/ac

