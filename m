From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPI: AC: add sysfs support
Date: Sun, 12 Aug 2007 12:59:48 +0400
Message-ID: <46BECC04.3080703@gmail.com>
References: <46BE1494.2070305@gmail.com> <200708112345.11948.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:50381 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759482AbXHLI7z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2007 04:59:55 -0400
Received: by ug-out-1314.google.com with SMTP id j3so522029ugf
        for <linux-acpi@vger.kernel.org>; Sun, 12 Aug 2007 01:59:53 -0700 (PDT)
In-Reply-To: <200708112345.11948.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Len Brown wrote:
> On Saturday 11 August 2007 15:57, Alexey Starikovskiy wrote:
>> +#if defined(CONFIG_POWER_SUPPLY) || defined(CONFIG_POWER_SUPPLY_MODULE)
>> +#define ENABLE_POWER_SUPPLY
>> +#include <linux/power_supply.h>
>> +#endif
> 
> sort of unfortunately to then have the #ifdef ENABLE_POWER_SUPPLY
> sprinkled throughout the code, though I don't immediately see
> a cleaner way to do it....
> 
We could make it "depend on POWER_SUPPLY" at some later point.

Regards,
Alex.
