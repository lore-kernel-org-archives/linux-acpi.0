From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: RFC: Light sensors, unifying current options?
Date: Fri, 11 Sep 2009 10:05:48 +0100
Message-ID: <4AAA12EC.1090204@cam.ac.uk>
References: <4A9FC9D7.20000@cam.ac.uk>	<1252308744.3483.414.camel@rzhang-dt>	<4AA4F194.1070507@cam.ac.uk>	<1252467684.3483.446.camel@rzhang-dt>	<4AA79144.8060104@cam.ac.uk>	<1252546449.3483.476.camel@rzhang-dt>	<4AA8CF57.4010409@cam.ac.uk>	<1252634101.3483.514.camel@rzhang-dt> <20090911092049.70887ad0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:34160 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbZIKJFi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2009 05:05:38 -0400
In-Reply-To: <20090911092049.70887ad0@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Jean Delvare wrote:
> On Fri, 11 Sep 2009 09:55:01 +0800, Zhang Rui wrote:
>> On Thu, 2009-09-10 at 18:05 +0800, Jonathan Cameron wrote:
>>> Some sensors, e.g. tsl2561 use an internal clock to do sampling and hence
>>> have some predefined period in which the reading taken doesn't change.
>>> Perhaps exporting said period would be useful to userspace?
>>>
>> I don't think so.
>> IMO, the tsl2561 driver should handle this, and there is no need to
>> annoy the user space.
>> i.e. users always assume the content of "illuminance" attribute is
>> valid, and it's the driver's job to make this true. We don't need to
>> document this.
> 
> I agree with Rui on this. Let's not delegate everything to user-space,
> otherwise it's pointless to write kernel drivers in the first place.
Agreed, if anyone has an application they can add the relevant hooks when
they need them.

