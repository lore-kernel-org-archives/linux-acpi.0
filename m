From: Huang Ying <ying.huang@intel.com>
Subject: Re: [BUGFIX] ACPI, APEI, EINJ Param support is disabled by default
Date: Thu, 21 Jul 2011 10:54:13 +0800
Message-ID: <4E2794D5.1030104@intel.com>
References: <1311149369-20624-1-git-send-email-ying.huang@intel.com> <20110721024204.GJ8006@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44702 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab1GUCyQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Jul 2011 22:54:16 -0400
In-Reply-To: <20110721024204.GJ8006@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

On 07/21/2011 10:42 AM, Andi Kleen wrote:
>>  
>> +static bool param_extension;
>> +module_param(param_extension, bool, 0);
> 
> Make it 0644, then it can be changed at runtime. No need to require a reboot.

Normally, EINJ is compiled as module, so we can change it at load time
without a reboot.

Do we need the real runtime switching capability?

Best Regards,
Huang Ying
