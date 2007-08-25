From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.23-rc3-mm1
Date: Sat, 25 Aug 2007 00:28:09 -0400
Message-ID: <20070825042809.GA15863@redhat.com>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org> <46CF695D.1020008@imap.cc> <20070824170702.a2c51084.akpm@linux-foundation.org> <46CF7C3F.10707@imap.cc> <20070824203000.1d710cee.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbXHYE3k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Aug 2007 00:29:40 -0400
Content-Disposition: inline
In-Reply-To: <20070824203000.1d710cee.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>, Thomas Renninger <trenn@suse.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Fri, Aug 24, 2007 at 08:30:00PM -0700, Andrew Morton wrote:
 
 > >  <6>Linux agpgart interface v0.102
 > > +<6>rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
 > > +<4>rtc_cmos: probe of 00:03 failed with error -16
 > > +<6>agpgart: suspend/resume problematic: resume with 3D/DRI active may lockup X.Org
 > > +<4>on some chipset/BIOS combos (see DEBUG_AGP_PM in intel-agp.c)
 > >  <6>agpgart: Detected an Intel 965Q Chipset.
 > >  <6>agpgart: Unknown page table size, assuming 512KB
 > >  <6>agpgart: Detected 7676K stolen memory.
 > >  <6>agpgart: AGP aperture is 256M @ 0x40000000
 > > -<6>rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
 > > -<4>rtc_cmos: probe of 00:03 failed with error -16
 > 
 > I wonder if that was supposed to happen.  It's also happening in 2.6.23-rc3
 > base.
 
EBUSY. I've seen this happen when you have both CONFIG_RTC and
CONFIG_RTC_DRV_CMOS set.

	Dave

-- 
http://www.codemonkey.org.uk
