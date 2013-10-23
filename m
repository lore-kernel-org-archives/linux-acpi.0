From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC PATCH 0/3] ACPI: ARM AMBA bus connector resource
Date: Wed, 23 Oct 2013 15:37:47 +0800
Message-ID: <52677CCB.7090508@linaro.org>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com> <CE40542A5D952D47989966E71788B1840156EDDB@satlexdag05.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:42003 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3JWHhu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2013 03:37:50 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so498683pdj.7
        for <linux-acpi@vger.kernel.org>; Wed, 23 Oct 2013 00:37:50 -0700 (PDT)
In-Reply-To: <CE40542A5D952D47989966E71788B1840156EDDB@satlexdag05.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Anderson, Brandon" <Brandon.Anderson@amd.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "naresh.bhat@linaro.org" <naresh.bhat@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

On 2013-10-23 8:13, Anderson, Brandon wrote:
> Is the proposed ASL format appropriate? I recognize that the ASL

It is ok for me. it represents the device topology very clear also.

> definitions for these devices must be standardized across all ARM ACPI
> platform definitions if we want the software to work consistently,
> so this is an important aspect to agree upon.
> 
> How about contrasting it with an alternative where each device has _HID
> of "AMBA0000" and there's no top-level 'Device (AMBA)'? This would mean
> that all the devices would be labeled by ACPI subsystem as "AMBA0000:NN" 
> instead of "device:NN". However, with this solution there would be no easy
> way to define a default clock. See example below.

I think a top-level 'Device (AMBA)' is needed. there is a good example
for PCI host bridge, its HID is PNP0A08 or PNP0A03, and there are a top level
device for PCI host bridge and child devices with different HIDs.

if there's no top-level 'Device (AMBA)', AMBA0000:NN will confuse people if
there are multi AMBAs in the system, people will think that AMBA0000:01 is
the second AMBA bus in the system but not some devices under AMBA bus.

Thanks
Hanjun

