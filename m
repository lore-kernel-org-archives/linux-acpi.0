From: ZhangRui <rui.zhang@intel.com>
Subject: Re: X200: Brightness broken since 2.6.29-rc4-58-g4c098bc
Date: Mon, 16 Feb 2009 17:06:59 +0800
Message-ID: <1234775219.4998.1.camel@rzhang-desktop>
References: <20090213093354.GA10175@denkbrett.schottelius.org>
	 <20090213094200.GC17774@elte.hu>
	 <alpine.LFD.2.00.0902131302240.3671@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60552 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbZBPJFv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Feb 2009 04:05:51 -0500
In-Reply-To: <alpine.LFD.2.00.0902131302240.3671@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Nico Schottelius <nico-linux-20090213@schottelius.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

hi, Nico,

do you have an external graphics card as well as the integrated intel
graphics on your laptops?

please attach the dmesg and lspci output.

thanks,
rui




On Sat, 2009-02-14 at 02:05 +0800, Len Brown wrote:
> > > When using
> > >   - vmlinuz-2.6.29-rc4-ikn-00058-g4c098bc or
> > >   - vmlinuz-2.6.29-rc4-ikn-00211-g37bed90
> > > 
> > > the brightness of the LCD is almost off (lowest level),
> > > although kernel reports otherwise:
> > > 
> > > [10:31] ikn:~% cat /proc/acpi/video/VID/LCD0/brightness 
> > > levels:  20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 100
> > > current: 100
> > > 
> > > Changing the brightness via echo 20 > /proc/acpi/video/VID/LCD0/brightness
> > > only changes the value displayed, the display always keeps the same
> > > brightness.
> > > 
> > > The last time I saw it working was vmlinuz-2.6.29-rc4-ikn-00001-gd5b5623.
> 
> Nico,
> there are not a lot of changes between rc4 and the breakage,
> (and none of them jump out at me) can you git-bisect?
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

