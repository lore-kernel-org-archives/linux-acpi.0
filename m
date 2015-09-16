From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms using 'global_lock'
Date: Wed, 16 Sep 2015 04:06:07 +0200
Message-ID: <2327281.tcr4Ty65Wu@vostro.rjw.lan>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org> <1515364.kIriLUmZv6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60832 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750994AbbIPBiH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2015 21:38:07 -0400
In-Reply-To: <1515364.kIriLUmZv6@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lv Zheng <lv.zheng@intel.com>, gregkh@linuxfoundation.org, linaro-kernel@lists.linaro.org, sboyd@codeaurora.org, arnd@arndb.de, stable@vger.kernel.org, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wednesday, September 16, 2015 03:57:05 AM Rafael J. Wysocki wrote:
> On Tuesday, September 15, 2015 02:04:58 PM Viresh Kumar wrote:
> > global_lock is defined as an unsigned long and accessing only its lower
> > 32 bits from sysfs is incorrect, as we need to consider other 32 bits
> > for big endian 64 bit systems.
> > 
> > Fix that by making global_lock an u32 instead.
> > 
> > Cc: <stable@vger.kernel.org>  # v4.1+
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > ---
> > Its marked just for # v4.1+, because arm64 has the first 64 big-endian
> > platform with ACPI. And ACPI support for that is mainlined recently
> > only (Arnd Bergmann).
> 
> OK
> 
> So are you aware of any ARM platform implementing the ACPI EC?
> 
> I am not.  Moreover, I'm not aware of any plans in that area.

In any case, please just split the EC-related changes off from your second
patch and send them separately.

Thanks,
Rafael

