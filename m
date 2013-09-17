From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 06/14] ACPICA: Validate start object for
 acpi_walk_namespace.
Date: Tue, 17 Sep 2013 19:48:43 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEED9D4@ORSMSX103.amr.corp.intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<557903201460512616d36b45c10d989f7196a690.1377844863.git.lv.zheng@intel.com>
 <CAJvTdKnjwTG+M-2-xKQnhd0e1GfT8VeqxBLm+zQ31xmjEKKz2g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E8802463FD2@SHSMSX101.ccr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEED6FF@ORSMSX103.amr.corp.intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C9484527551C@FMSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40439 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab3IQTsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Sep 2013 15:48:45 -0400
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C9484527551C@FMSMSX106.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

I would also say something like:

"Adds additional input parameter validation"

> -----Original Message-----
> From: Brown, Len
> Sent: Tuesday, September 17, 2013 12:46 PM
> To: Moore, Robert; Zheng, Lv
> Cc: Wysocki, Rafael J; linux acpi
> Subject: RE: [PATCH 06/14] ACPICA: Validate start object for
> acpi_walk_namespace.
> 
> > Just adds a sanity check.
> 
> Ideal if commit messages answer the question:
> 
> "Is this patch important?"
> "If yes, what bad things happen if I don't have it in my kernel?"
> 
> Remember, the commit messages have customers.
> Nice to have a BZ referenced, but this BZ entry had no such information,
> and "prevent problems later" didn't answer that key question either.
> 
> thanks,
> -Len

