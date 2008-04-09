From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [RFC] [PATCH 3/3] Add the support for alarm time relative to
 current time in sysfs
Date: Wed, 9 Apr 2008 09:58:59 +0200
Message-ID: <20080409095859.6475cd3d@i1501.lan.towertech.it>
References: <1207723076.5997.22.camel@yakui_zhao.sh.intel.com>
	<200804090051.23829.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0.towertech.it ([213.215.222.73]:33041 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752638AbYDIIFm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 04:05:42 -0400
In-Reply-To: <200804090051.23829.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, akpm@linux-foundation.org

On Wed, 9 Apr 2008 00:51:23 -0700
David Brownell <david-b@pacbell.net> wrote:

> > It is more reasonable to add the support for the alarm time 
> > relative to current RTC time.(the unit is second)
> > For example: 
> > If the RTC is required to generate alarm after 2 minutes, the following will
> > be OK.
> > 	echo +120 > /sys/class/rtc/rtc0/wakealarm
> > or      echo +0x78 > /sys/class/rtc/rtc0/wakealarm
> > 
> > 
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > Signed-off-by: Zhang Rui  <rui.zhang@intel.com>
> 
> Makes sense.
> 
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>

 agreed.

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

