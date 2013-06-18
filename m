From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 05/16] ACPICA: Split table print utilities to a new a
 separate file
Date: Tue, 18 Jun 2013 18:46:53 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE8850D@ORSMSX103.amr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<98af6637d808d7c3072853b37f4502e5cf56000e.1369274559.git.lv.zheng@intel.com>
 <CAJvTdK=R+rsCX_LBUNenDO4rd1JN+FGfo9BGwf9Rt2ppovaW2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3365 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555Ab3FRSrF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2013 14:47:05 -0400
In-Reply-To: <CAJvTdK=R+rsCX_LBUNenDO4rd1JN+FGfo9BGwf9Rt2ppovaW2A@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

Correct, should be "no functional changes".


> -----Original Message-----
> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Wednesday, June 12, 2013 10:04 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> Subject: Re: [PATCH 05/16] ACPICA: Split table print utilities to a new a
> separate file
> 
> On Fri, Jun 7, 2013 at 8:59 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > From: Bob Moore <robert.moore@intel.com>
> >
> > Improves configurability of ACPICA.
> 
> 
> Just code movement, no logic changes or even any code changes, yes?
> If so, please state that in the commit message.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
