From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Thu, 5 Apr 2007 03:35:35 -0700
Message-ID: <200704050335.36141.david-b@pacbell.net>
References: <200704031741.42273.david-b@pacbell.net> <20070405092638.GA30208@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:37180 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S966071AbXDEKfi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2007 06:35:38 -0400
In-Reply-To: <20070405092638.GA30208@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux ACPI list <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thursday 05 April 2007 2:26 am, Matthew Garrett wrote:
> On Tue, Apr 03, 2007 at 05:41:42PM -0700, David Brownell wrote:
> > This updates /proc/acpi/wakeup to be more informative, primarily by showing
> > the sysfs node associated with each wakeup-enabled device.  Example:
> 
> This looks good. 

Also "good at exposing some puzzling info" ... ;)


> > 	S139	  S4	 disabled  
> 
> Any idea what this one is? There's the potential for all sorts of weird 
> platform devices to expose wakeup capabilities.

My guess is Firewire (IEEE 1394); "F193" on a different system (different
chip vendor) *is* Firewire.  This BIOS seems to have wrongly copied ACPI
tables from a similar system with a fancier southbridge from the same
chip vendor.  (ISTR the vendor's reference design used the fancier chip.)


> > Eventually this file should be removed, but until then it's almost the only
> > way we have to tell how the relevant ACPI tables are broken (and cope).  In
> > that example, two devices don't actually exist (USB3, S139), one can't issue
> > wakeup events (PCI0), and two seem harmlessly (?) confused (MDM and AUD are
> > the same PCI device, but it's the _modem_ that does wake-on-ring).  
> 
> Could the MDM entry be referring to the modem codec on the ac97 or 
> hda bus? 

That's my assumption; yes.   Another system lists "AUD0" and "MODM", but
shows neither as a wakeup device.  As I said, "confused".

- Dave
