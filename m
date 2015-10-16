From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: set return value to const char for some functions
Date: Fri, 16 Oct 2015 03:37:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D980841@ORSMSX112.amr.corp.intel.com>
References: <1444849635-14456-1-git-send-email-clabbe.montjoie@gmail.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37D9803BD@ORSMSX112.amr.corp.intel.com>
	 <1444875266.2718.37.camel@perches.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37D9806CC@ORSMSX112.amr.corp.intel.com>
 <1444953586.22921.0.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22688 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbbJPDh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2015 23:37:57 -0400
In-Reply-To: <1444953586.22921.0.camel@perches.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

If you don't like the quote, just stick with my first assessment.


> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Thursday, October 15, 2015 5:00 PM
> To: Moore, Robert
> Cc: LABBE Corentin; Zheng, Lv; Wysocki, Rafael J; lenb@kernel.org; linux-
> acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; Box,
> David E
> Subject: Re: [PATCH] acpi: set return value to const char for some
> functions
> 
> On Thu, 2015-10-15 at 19:32 +0000, Moore, Robert wrote:
> > if you started to use "const" for some methods you usually forced to
> > use this in most of your code. But the time spent for maintaining
> > (typing, recompiling when some const is missing, etc.) of
> > const-correctness in code seems greater than for fixing of possible
> > (very rare) problems caused by not using of const-correctness at all
> 
> c is not c++.
> 
> "seems" is a dubious statement.

