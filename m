From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2] ACPI: Fix resource_lock dead lock in acpi_power_on_device
Date: Fri, 14 Sep 2012 09:21:25 +0800
Message-ID: <50528695.2090602@intel.com>
References: <1347440853-12540-1-git-send-email-aaron.lu@intel.com> <201209140026.35993.rjw@sisk.pl> <50528516.2020002@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16892 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab2INBVn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Sep 2012 21:21:43 -0400
In-Reply-To: <50528516.2020002@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Leb Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On 09/14/2012 09:15 AM, Aaron Lu wrote:
>>
>> Good catch, thanks.
>>
>> I hope Len won't mind if I take it for v3.6.
>>
> 
> Yes, that would be good.
> And the commit enters v3.4, so a stable tag may need be added.
> 

On another thought, it may not be needed for pre v3.6 kernel as the only
code that uses this interface appeared in v3.6-rc1.

Thanks,
Aaron
