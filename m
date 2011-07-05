From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2 3/4] ACPI, APEI, Add APEI bit support in generic _OSC
 call
Date: Tue, 05 Jul 2011 08:24:54 +0800
Message-ID: <4E1259D6.5050405@intel.com>
References: <1309163160-3201-1-git-send-email-ying.huang@intel.com> <1309163160-3201-4-git-send-email-ying.huang@intel.com> <201107041228.51671.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53292 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662Ab1GEAY5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jul 2011 20:24:57 -0400
In-Reply-To: <201107041228.51671.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>

Hi, Thomas,

On 07/04/2011 06:28 PM, Thomas Renninger wrote:
> On Monday, June 27, 2011 10:25:59 AM Huang Ying wrote:
> 
>>  extern bool osc_sb_apei_support_acked;
>>  
>> +extern bool osc_sb_apei_support_acked;
>> +
> double osc_sb_apei_support_acked declaration?

Sorry, I have some issue with patch management.  Will fix it in the new
version.

Best Regards,
Huang Ying
