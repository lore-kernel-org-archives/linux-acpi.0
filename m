From: Daniel Drake <dsd@gentoo.org>
Subject: Re: /proc/acpi/thermal_zone/THRM/temperature always reports 40C -
 is this a bug?
Date: Sun, 15 Oct 2006 15:50:18 -0400
Message-ID: <453290FA.8070003@gentoo.org>
References: <452D945F.6040709@gentoo.org> <200610130117.02392.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp125.iad.emailsrvr.com ([207.97.245.125]:3215 "EHLO
	smtp125.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1422885AbWJOTvG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Oct 2006 15:51:06 -0400
In-Reply-To: <200610130117.02392.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, eaburns@cisunix.unh.edu

Len Brown wrote:
> On Wednesday 11 October 2006 21:03, Daniel Drake wrote:
>> Hi,
>>
>> Ethan, at http://bugs.gentoo.org/142635 reports that the thermal zone 
>> always reads 40C. Is this something that should be filed at the kernel 
>> bugzilla for further investigation, or can we simply blame a 
>> buggy/unfixable BIOS? I understand that i2c/hwmon is the more common way 
>> of measuring temperatures.
> 
> Probably this isn't specific to a gentoo build and would happen just
> the same with a kernel.org build.  So if it is a bug, it is probably an upstream bug.

Agreed - I was asking whether you regard this as a real upstream bug, or 
a broken ACPI implementation not worth fixing.

> It would be good to verify that ACPI events in general
> are working on the box -- eg. the power button etc -- as a failure
> there would also be more interesting than unchanging temperature.

The power button does generate events, so it's not completely broken.

I guess this can just be passed off as a small BIOS bug? If you'd like 
us to open a bug for it anyway, just say.

Thanks!
Daniel

