From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Fri, 11 Apr 2008 20:44:21 +0800
Message-ID: <1207917861.9448.42.camel@yakui_zhao.sh.intel.com>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com>
	 <200804090313.34805.david-b@pacbell.net>
	 <1207911866.9448.34.camel@yakui_zhao.sh.intel.com>
	 <200804102046.48082.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33913 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbYDKExh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 00:53:37 -0400
In-Reply-To: <200804102046.48082.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Thu, 2008-04-10 at 20:46 -0700, David Brownell wrote:
> On Friday 11 April 2008, Zhao Yakui wrote:
> > But The following is reasonable. IMO.
> >  For October: 0x0A will be written into the RTC region
> > (MONTH_ALARM). But in fact 0x10 should be written.
> >        /* Writing 0xff means "don't care" or "match all".  */
> >  
> > -       mon = t->time.tm_mon;
> > -       mon = (mon < 12) ? BIN2BCD(mon) : 0xff;
> > -       mon++;
> > +       mon = t->time.tm_mon + 1;
> > +       mon = (mon <= 12) ? BIN2BCD(mon) : 0xff;
> > 
> > Is there an opportunity to merge it?
> 
> Sure.  Submit that as a patch by itself.
> 
How about the following issue? 
  There is another question about the driver rtc and rtc-cmos.
rtc driver is in drivers/char/ and rtc-cmos is in drivers/rtc/
On some laptops the two drivers will share the same memory/irq resource,
which will cause that rtc-cmos driver can't work well after the rtc
driver is already loaded.(Of course RTC sys I/F isn't created in rtc
driver.)
  How to solve this issue?  

Best regards
   Yakui

> - Dave
> 

