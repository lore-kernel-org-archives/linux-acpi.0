From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with
 ACPI Operation Region resources
Date: Fri, 26 Oct 2007 22:39:42 +0200
Message-ID: <20071026223942.6dbfebe0@hyperion.delvare>
References: <1193236319.4590.225.camel@queen.suse.de>
	<200710252159.11594.bjorn.helgaas@hp.com>
	<1193395520.4590.349.camel@queen.suse.de>
	<200710260709.20716.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:1149 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757327AbXJZUjp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2007 16:39:45 -0400
In-Reply-To: <200710260709.20716.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>

Hi Bjorn,

On Fri, 26 Oct 2007 07:09:19 -0600, Bjorn Helgaas wrote:
> On Friday 26 October 2007 4:45:20 am Thomas Renninger wrote:
> > Maybe the list set up by this patch set should be similarly exported
> > like /proc/ioports /proc/iomem
> > to where ever appropriate (maybe /sys/devices/system/acpi/opreg_io
> > and /sys/devices/system/acpi/opreg_mem?) to get a better overview what
> > kind of devices are served by the Op regions on different machines.
> 
> I want to try hard to avoid making ACPI a special case in this way.
> The current /proc/io{ports,mem} contains reservations for everything
> else.  I'd hate to have to look two places just because of ACPI.

I agree. I consider the patches Thomas and myself just posted as a
temporary workaround (even though we can't say how long this
"temporary" will last). Ideally, we should register the I/O ports
declared in ACPI OpRegions - just not now as it would break too many
drivers. Time we tell how "clean" we manage to go.

-- 
Jean Delvare
