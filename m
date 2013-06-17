From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 15/16] ACPICA: _CST repair: Handle null package entries
Date: Mon, 17 Jun 2013 16:41:45 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88016@ORSMSX103.amr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<f941986213920b382a8f43af43caec298cd16a5a.1369274559.git.lv.zheng@intel.com>
 <CAJvTdKm06aCeLvV28=TSrv5wqoapUY0vh2=ppY5p5pFW0pUKFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35656 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab3FQQlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2013 12:41:47 -0400
In-Reply-To: <CAJvTdKm06aCeLvV28=TSrv5wqoapUY0vh2=ppY5p5pFW0pUKFw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

This one is just adding additional checks on the _CST that are obvious errors in the AML. The eventual goal of the "repair" code in ACPICA is to never return a bad package from things like _CST. In other words, an AE_OK guarantees that the return value is usable. 

So, this is an additional implementation of this longer-range project.


> -----Original Message-----
> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Wednesday, June 12, 2013 11:00 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package
> entries
> 
> On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > Sort package only after null/bad elements have been removed.
> > Lv Zheng.
> 
> 
> again, please explain WHY.
> 
> Every line of change to the kernel adds risk.
> I see no justification in this commit message why any risk should be added
> to the kernel.
> 
> Nacked-by: Len Brown <len.brown@intel.com>
