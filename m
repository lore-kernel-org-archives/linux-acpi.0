From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 03/16] ACPICA: Standardize all switch() blocks
Date: Tue, 18 Jun 2013 18:46:35 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88506@ORSMSX103.amr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<91d82cf071b27d24ec8a43da281fc7e1c3d542a9.1369274559.git.lv.zheng@intel.com>
 <CAJvTdK=y7Zkwbkp18xo405HGKNh2uiHd0-zP5t1qHVD4eEfK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56489 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555Ab3FRSqh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2013 14:46:37 -0400
In-Reply-To: <CAJvTdK=y7Zkwbkp18xo405HGKNh2uiHd0-zP5t1qHVD4eEfK=w@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, "Guan, Chao" <chao.guan@intel.com>

There were some really bad examples, where 2 or even 3 blank lines were inserted. These were the most severe cases. So we standardized on one blank line, unless there is a multi-line comment.


> -----Original Message-----
> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Wednesday, June 12, 2013 8:59 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi; Guan, Chao
> Subject: Re: [PATCH 03/16] ACPICA: Standardize all switch() blocks
> 
> > After many years, different formatting for switch() has crept in.
> > This change makes every switch block identical. Chao Guan.
> > ACPICA bugzilla 997.
> 
> So what is the new format?
> Looks like a blank line after every "case", except no blank line if
> comment?
> 
> That would be a good thing to say in the commit message...
> 
> Also, for patches such as this, please note in the commit message that it
> is white-space only (indeed, in this case looks like blank lines only) and
> no functionality changes.
> 
> That would help optimize precious reviewer time, and also make it clear to
> those doing a bisect who read only the commit message and not the patch.
> 
> thanks,
> Len Brown
> Intel Open Source Technology Center
