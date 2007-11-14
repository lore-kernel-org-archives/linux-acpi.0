From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Wed, 14 Nov 2007 17:44:01 +0000
Message-ID: <20071114174401.GA4265@srcf.ucam.org>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113170129.GA20185@kroah.com> <20071113202154.GA22812@ldl.fc.hp.com> <20071113202632.GA3227@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:50908 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbXKNRqr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2007 12:46:47 -0500
Content-Disposition: inline
In-Reply-To: <20071113202632.GA3227@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alex Chiang <achiang@hp.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, matthew@wil.cx, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, Nov 13, 2007 at 12:26:32PM -0800, Greg KH wrote:

> Doesn't /sys/firmware/acpi give you raw access to the correct tables
> already?
> 
> And isn't there some other tool that dumps the raw ACPI tables?  I
> thought the acpi developers used it all the time when debugging things
> with users.

Dumping raw ACPI tables isn't adequate - _SUN might be a complex ACPI 
method with multiple reads and writes to raw hardware, and we really 
don't want to do that in userspace. The only way to do this reliably is 
in the kernel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
