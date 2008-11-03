From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: ACPI reads wrong temperature
Date: Mon, 03 Nov 2008 10:05:36 +0800
Message-ID: <1225677936.26020.17.camel@yakui_zhao.sh.intel.com>
References: <20081031140247.325670@gmx.net>
	 <20081031143030.GA9177@srcf.ucam.org> <20081031210913.3180@gmx.net>
	 <20081102092541.GE10983@srcf.ucam.org>  <20081102113112.316040@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28263 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969AbYKCB6q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Nov 2008 20:58:46 -0500
In-Reply-To: <20081102113112.316040@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Mahlknecht <mali100@gmx.net>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2008-11-02 at 19:31 +0800, Peter Mahlknecht wrote:
> > > Thanks for the hint. I get the wrong temperatures after loading the 
> > > lm90 module (hwmon driver), but also if i load em28xx_cx25843, which 
> > > is a part of the driver for my tv-card. Both modules depend on 
> > > i2c-core, so probably the bug is related to the i2c bus?
> > 
> > In the lm90 case it's almost certainly because you have the firmware and 
> > Linux trying to access the chip at the same time. Since it has indexed 
> > registers, this fails very miserably. I'm surprised that the TV card 
> > driver has any effect - it should be on an entirely spearate i2c bus. 
> > Are you sure you don't have lm90 loaded in that case?
> Yes, I am. I had also a talk with the author of the Tv-card driver and he suggested to but the problem on the lm-sensors ml: http://lists.lm-sensors.org/pipermail/lm-sensors/2008-November/024610.html
> We know now that the problem is related to the i2c-i801 driver.
Yes. This is related with i2c-i801 driver.
We have a similar bug. 
   http://bugzilla.kernel.org/show_bug.cgi?id=10245

In this bug after the driver of lm_sensor is loaded, the system read the
incorrect temperature.  The root cause is that the SMBus is used by ACPI
for thermal management. After the lm_sensor is loaded, Linux will use
the same bus. There is the conflict. So if the Linux doesn't attach the
driver to the SMbus, it will be OK.

Will you please attach the output of acpidump, lspci -vxxx?

Thanks.

> 
> Peter 

