From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 13/16] ACPICA: Move _PRT repair into the standard
 complex repair module
Date: Tue, 18 Jun 2013 18:51:10 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88551@ORSMSX103.amr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<f2c59ef61be4cf02903c633ad38592121db86419.1369274559.git.lv.zheng@intel.com>
 <CAJvTdKnYif42oaWnP4MBQbi6XYg3AchJnxZPrTr1XPct=uS+6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22877 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756197Ab3FRSvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2013 14:51:22 -0400
In-Reply-To: <CAJvTdKnYif42oaWnP4MBQbi6XYg3AchJnxZPrTr1XPct=uS+6g@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

No functional change. This change simply moves the repair code from where it was originally implemented to the (more recent) repair module where it now belongs.

> -----Original Message-----
> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Wednesday, June 12, 2013 10:52 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> Subject: Re: [PATCH 13/16] ACPICA: Move _PRT repair into the standard
> complex repair module
> 
> Please re-send this patch with a commit message that clarifies whether any
> logical change in operation should result from this patch or not.
> 
> It looks like the answer is no, that this a clean-up of the implementation
> of a AML workaround -- but I shouldn't have to read the code to figure
> that out, and neither should anybody else.
> 
> Nacked-by: Len Brown <len.brown@intel.com>
