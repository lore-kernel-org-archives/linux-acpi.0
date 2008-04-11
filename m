From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Fri, 11 Apr 2008 08:30:25 +0200
Message-ID: <20080411083025.2ebc831f@i1501.lan.towertech.it>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com>
	<200804090313.34805.david-b@pacbell.net>
	<1207911866.9448.34.camel@yakui_zhao.sh.intel.com>
	<200804102046.48082.david-b@pacbell.net>
	<1207917861.9448.42.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0.towertech.it ([213.215.222.73]:51593 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758053AbYDKGa2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 02:30:28 -0400
In-Reply-To: <1207917861.9448.42.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: David Brownell <david-b@pacbell.net>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Fri, 11 Apr 2008 20:44:21 +0800
Zhao Yakui <yakui.zhao@intel.com> wrote:

> How about the following issue? 
>   There is another question about the driver rtc and rtc-cmos.
> rtc driver is in drivers/char/ and rtc-cmos is in drivers/rtc/
> On some laptops the two drivers will share the same memory/irq resource,
> which will cause that rtc-cmos driver can't work well after the rtc
> driver is already loaded.(Of course RTC sys I/F isn't created in rtc
> driver.)
>   How to solve this issue?  

The driver in drivers/char/ should not be loaded at all. the most recent
 Kconfig  will check and avoid letting you select both of them.

--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

