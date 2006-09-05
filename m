From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problem with resuming ATI SATA on HPC nx6325
Date: Tue, 5 Sep 2006 08:24:50 +0200
Message-ID: <20060905062438.GD1958@elf.ucw.cz>
References: <200609041332.19780.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8673 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965167AbWIEGZF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2006 02:25:05 -0400
Content-Disposition: inline
In-Reply-To: <200609041332.19780.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi!

> I've just installed SUSE 10.1 on a HPC 6325 notebook (x86_64, dual_core) with
> an ATI chipset.  It generally works just fine (well, except for some minor
> glitches), but I'm having problems with suspending it which seem to be ACPI
> related.
> 
> Namely, on the 2.6.18-rc5-mm1 kernel the hard drive is not accessible after
> a resume of device drivers (eg. in the resume-during-suspend phase of swsusp).
> On 2.6.18-rc5 swsusp works with the following drivers loaded:
> 
> cpufreq_ondemand
> powernow_k8
> freq_table
> af_packet
> ip6t_REJECT
> xt_tcpudp
> ipt_REJECT
> xt_state
> iptable_filter
> ip_conntrack
> nfnetlink
> ip_tables
> ip6table_filter
> ip6_tables
> x_tables
> ipv6
> ext3
> jbd
> fan
> thermal
> processor
> sg
> atiixp
> sata_sil
> libata
> ide_disk
> ide_core
> 
> but if ohci_hcd and ehci_hcd are loaded additionally, the SATA thing doesn't
> resume properly (if only one of ehci_hcd or ohci_hcd is loaded, it works).

So situation is:

2.6.18-rc5: works in any config

2.6.18-rc5-mm1: if ohci+ehci+sata are loaded, SATA breaks during
resume

, right? How does it breaks? Are interrupts shared between the two?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
