From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPICA 20140214 auto-serialize weirds my machine...
Date: Fri, 14 Mar 2014 20:14:57 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7F98B6@ORSMSX103.amr.corp.intel.com>
References: <14866.1394813101@turing-police.cc.vt.edu>
 <20140314173801.GA3755@kria>
            <94F2FBAB4432B54E8AACC7DFDE6C92E37C7F9876@ORSMSX103.amr.corp.intel.com>
 <22867.1394827457@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35690 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbaCNUO7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Mar 2014 16:14:59 -0400
In-Reply-To: <22867.1394827457@turing-police.cc.vt.edu>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Cc: Sabrina Dubroca <sd@queasysnail.net>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

We have reproduced the problem here, and have reached an understanding of the problem.

We are working on the solution, please disable auto-serialize for now.
Thanks,
Bob


> -----Original Message-----
> From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu]
> Sent: Friday, March 14, 2014 1:04 PM
> To: Moore, Robert
> Cc: Sabrina Dubroca; Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> Subject: Re: ACPICA 20140214 auto-serialize weirds my machine...
> 
> On Fri, 14 Mar 2014 19:36:54 -0000, "Moore, Robert" said:
> > Sabrina, Valdis:
> >
> > Do either of you see any error messages like this:
> >
> > ACPI Error: Mutex [0x1] is not acquired, cannot release
> (20140214/utmutex-437)
> 
> All of my "ACPI Error:" messages look like either:
> 
> ACPI Error: Cannot acquire Mutex for method [SNVC], current SyncLevel is
> too large (1) (20140214/dsmethod-362)
> 
> or
> 
> ACPI Error: Method parse/execution failed [\ECBT] (Node ffff88012d02d588),
> AE_AML_MUTEX_ORDER (20140214/psparse-536)
> 
> I should have a git bisect finished shortly...
