From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Discussion on device's runtime wake capability
Date: Wed, 10 Oct 2012 15:54:23 +0800
Message-ID: <507529AF.4080701@intel.com>
References: <5073C2D0.1080900@intel.com> <9718124.Sj45DoTPo2@vostro.rjw.lan> <5074C70C.9090704@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36946 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab2JJHy3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2012 03:54:29 -0400
In-Reply-To: <5074C70C.9090704@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On 10/10/2012 08:53 AM, Aaron Lu wrote:
> On 10/10/2012 04:48 AM, Rafael J. Wysocki wrote:
>> On Tuesday 09 of October 2012 14:23:12 Aaron Lu wrote:
>>> BTW, _S0W seems to be a good hint whether the device supports run wake
>>> from ACPI's perspective.
>>
>> Yes, it is a _hint_.
> 
> And I think it is a better hint than _PRW.

I probably need to add that, devices only have _PRW are of cource
runtime wake capable. This is already handled in our current code.

Thanks,
Aaron

