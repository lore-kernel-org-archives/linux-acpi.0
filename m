From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH]  ACPI:  Ignore AE_NOT_FOUND error of EC _REG method
	and continue to initialize EC
Date: Tue, 29 Jul 2008 08:54:52 +0800
Message-ID: <1217292892.4306.7.camel@yakui_zhao.sh.intel.com>
References: <1217215550.4016.6.camel@yakui_zhao.sh.intel.com>
	 <20080728145926.GG28253@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42710 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbYG2AmO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jul 2008 20:42:14 -0400
In-Reply-To: <20080728145926.GG28253@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 2008-07-28 at 16:59 +0200, Andi Kleen wrote:
> On Mon, Jul 28, 2008 at 11:25:50AM +0800, Zhao Yakui wrote:
> > Subject:ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC 
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> > On some broken BIOS the ACPI object in EC _REG method can't be found in
> > ACPI namespace, which causes that the AE_NOT_FOUND status code is returned by
> > the EC _REG object. In such case the EC device can't be initialized correctly, 
> 
> Thanks. Queued for test. How urgent is this? Do we need to consider it 
> for .27?
Not very urgent. It is a workaround patch for some broken BIOS. Of course it is also OK for .27.

Windows can work well on the broken BIOS(the error is ignored by
windows). Maybe we can also ignore such error and continue to initialize
EC.

Thanks.
> -Andi

