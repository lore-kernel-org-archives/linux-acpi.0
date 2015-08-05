From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH] acpi, property: Export acpi_dev_prop_read_single call.
Date: Wed, 05 Aug 2015 15:43:18 +0200
Message-ID: <55C212F6.40504@linaro.org>
References: <1438729319-9146-1-git-send-email-ddaney.cavm@gmail.com> <5621301.c1YGTkGNQk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:32991 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbHENnW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Aug 2015 09:43:22 -0400
Received: by lbbyj8 with SMTP id yj8so24661712lbb.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Aug 2015 06:43:20 -0700 (PDT)
In-Reply-To: <5621301.c1YGTkGNQk@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Robert Richter <rrichter@cavium.com>, David Daney <david.daney@cavium.com>

On 05.08.2015 15:48, Rafael J. Wysocki wrote:
> On Tuesday, August 04, 2015 04:01:59 PM David Daney wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> Fixes the following build error when building drivers as modules:
>>
>>   ERROR: "acpi_dev_prop_read_single" [drivers/net/phy/mdio-octeon.ko] undefined!
>>   ERROR: "acpi_dev_prop_read_single" [drivers/net/ethernet/cavium/thunder/thunder_bgx.ko] undefined!
>
> Can you please tell me why the drivers in question use that function
> directly, although they aren't supposed to?
>
> Clearly, their authors had not tried to build them as modules or they
> would have noticed the problem at the development stage already.
>
> What would be wrong with using the generic device properties API instead?
>
Yes, you are right. We should use:
int device_property_read_u64_array(struct device *dev, const char 
*propname, u64 *val, size_t nval);

Regards,
Tomasz

