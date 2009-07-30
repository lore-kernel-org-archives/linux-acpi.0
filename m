From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 04:18:53 +0100
Message-ID: <20090730031853.GB1202@srcf.ucam.org>
References: <20090730020623.GB26389@srcf.ucam.org> <20090730023313.GA27493@sli10-desk.sh.intel.com> <20090730025657.GE26389@srcf.ucam.org> <20090730031723.GB24959@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42923 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbZG3DSy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2009 23:18:54 -0400
Content-Disposition: inline
In-Reply-To: <20090730031723.GB24959@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jul 30, 2009 at 11:17:23AM +0800, Shaohua Li wrote:
> On Thu, Jul 30, 2009 at 10:56:57AM +0800, Matthew Garrett wrote:
> > Yes, that would basically work for me. I'm still slightly curious as to 
> > why my hardware's not giving me the correct ACPI notification, though - 
> > I guess this may be entirely untested under Windows.
> IIRC, you don't need to know which GPE for wakeup. The GPE is already enabled.
> And all required are just to register a notifier handler (register_acpi_bus_notifier), and check the ACPI_NOTIFY_DEVICE_WAKE event.

The problem is that the GPE method in the DSDT calls an SMI to work out 
which device generated the notification, and that SMI claims that none 
of them did. This means that no notification is sent. I may have to try 
to find someone in Dell to ask about this.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
