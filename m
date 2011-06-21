From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 1/4] ACPI, APEI, GHES, Prevent GHES to be built as module
Date: Tue, 21 Jun 2011 15:30:08 +0800
Message-ID: <4E004880.4030000@intel.com>
References: <1308640587-24502-1-git-send-email-ying.huang@intel.com> <1308640587-24502-2-git-send-email-ying.huang@intel.com> <20110621072301.GA3263@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63110 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110Ab1FUHaK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jun 2011 03:30:10 -0400
In-Reply-To: <20110621072301.GA3263@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>

Hi, Andi,

Thanks for comments!

On 06/21/2011 03:23 PM, Andi Kleen wrote:
> On Tue, Jun 21, 2011 at 03:16:24PM +0800, Huang Ying wrote:
>> GHES (Generic Hardware Error Source) is used to process hardware error
>> notification in firmware first mode.  But because firmware first mode
>> can be turned on but can not be turned off, it is unreasonable to
>> unload the GHES module with firmware first mode turned on.  To avoid
>> confusion, this patch makes GHES can be enable/disable in
>> configuration time, but not built as module and unload at run time.
> 
> It's better to keep it as a module, but disable unloading.
> You can do that with a __module_get(THIS_MODULE) in the init code
> when FFM is detected.

There are two ways to turn on firmware first mode

1) APEI bit in generic _OSC call
2) Special APEI _OSC call

1) is run before GHES module loading.  If keeping GHES as a module, it
is possible that firmware first mode has been turned on with APEI bit in
generic _OSC call, but GHES module is prevented to be loaded via some
kind of module blacklist.  So I think it is better to prevent GHES to be
built as module.

Best Regards,
Huang Ying
