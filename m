From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 14/16] ACPICA: Add several repairs for _CST predefined
 name
Date: Tue, 18 Jun 2013 18:51:45 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88565@ORSMSX103.amr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<b2c18e07f4c9e59179c273d051924417053cd774.1369274559.git.lv.zheng@intel.com>
 <CAJvTdKk9i+qcmKhuoCzqoL_hDUgv8Y3qZrs=j=onUb46kZWZGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36750 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756197Ab3FRSwH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2013 14:52:07 -0400
In-Reply-To: <CAJvTdKk9i+qcmKhuoCzqoL_hDUgv8Y3qZrs=j=onUb46kZWZGQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

Correct, additional _CST sanity checks and repairs.

> -----Original Message-----
> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Wednesday, June 12, 2013 10:59 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> Subject: Re: [PATCH 14/16] ACPICA: Add several repairs for _CST predefined
> name
> 
> On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > Sort list based on the C-state, remove invalid/zero entries.
> > ACPICA BZ 890. Lv Zheng.
> 
> The commit message should not just say what the code does, it should more
> importantly answer WHY the change was made, and why anybody should care
> about the patch.
> 
> I think the answer here is that we are adding _CST sanity checking --
> presumably to deal with buggy AML?
> 
> What will we see happen after this patch that we did not see before it?
> 
> Nacked-by: Len Brown <len.brown@intel.com>
