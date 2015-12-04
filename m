From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/7] ACPI / LPSS: allow to use specific PM domain
 during ->probe()
Date: Fri, 4 Dec 2015 15:04:07 +0200
Message-ID: <56618F47.9080205@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <565733A2.6050900@linux.intel.com>
 <1448556317.15393.77.camel@linux.intel.com>
 <10907323.ZOUAMFPIfU@vostro.rjw.lan>
 <1448618173.15393.104.camel@linux.intel.com>
 <1449171008.15393.158.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4004 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197AbbLDNGX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Dec 2015 08:06:23 -0500
In-Reply-To: <1449171008.15393.158.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 12/03/2015 09:29 PM, Shevchenko, Andriy wrote:
> I briefly checked this for DMA issue. It will not help anyhow, so we
> *have to* move a power domain assignment to the BIND stage.
>
> For I2C and rest LPSS devices this might help (though didn't look
> deeply). My understanding that we assign those callbacks in the LPSS
> custom PM domain and call them explicitly in acpi_lpss.c.
>
> The code will be the same as we are using now to bring device from
> runtime suspend resume. This means whenever we call probe for e.g. I2C
> we end up in a sequence similar to:
>   pm_runtime_resume(I2C);
>   ->probe(I2C);
>   pm_runtime_suspend(I2C);
>
> I will try to mock up this and check if it will work, though have no
> idea what to do if I2C during probe calls pm_runtime_forbid().
>
> Jarkko, what do you think?
>
I suppose device core will handle it. If the runtime PM is forbidden or 
not initialized at all the device shouldn't idle.

-- 
Jarkko
