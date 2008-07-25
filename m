From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Acer Aspire One (Intel Atom's Motherboard) CPU Temp & Fan Speed
Date: Fri, 25 Jul 2008 09:38:39 +0800
Message-ID: <1216949919.1831.38.camel@yakui_zhao.sh.intel.com>
References: <f4897e880807240800n3c02c6bdw44c4827e098f61c2@mail.gmail.com>
	 <f4897e880807240932q33f3919et1d24cb8f98e8598e@mail.gmail.com>
	 <200807242302.04782.carlos@strangeworlds.co.uk>
	 <f4897e880807241628j4d557e91w1955044d43451247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43346 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbYGYB3i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jul 2008 21:29:38 -0400
In-Reply-To: <f4897e880807241628j4d557e91w1955044d43451247@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Simon Depiets <sdepiets@gmail.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, acpi@linux.intel.com, linux-acpi@vger.kernel.org

On Fri, 2008-07-25 at 01:28 +0200, Simon Depiets wrote:
> 2008/7/25 Carlos Corbacho <carlos@strangeworlds.co.uk>:
> > We'll also need the output of acpidump.
> >
> > -Carlos
> Hi,
> I've uploaded it here
> http://www.mmo-tools.com/acpi/acpidump.txt
>From the attached acpidump it seems that there is no defintion of
thermal_zone, FAN device or power resource device.
So we can't get any info about the temperature of thermal_zone or FAN
speed through ACPI interface.
Will you please check whether there is available bios to upgrade?
Will you please check whether the CPU temperature can be obtained by the
coretemp driver?

Thanks.
> 

