From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 11/16] ACPICA: Clear events initialized flag upon event
 component termination
Date: Tue, 18 Jun 2013 18:50:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE8853D@ORSMSX103.amr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<17a5d121655fce6e2438b10adaf8271dd05b454c.1369274559.git.lv.zheng@intel.com>
 <CAJvTdKkuQfOYZ49h4psmE7VJKVw3XWswSuLjL2m+hovRY6OSkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34249 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932823Ab3FRSuY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2013 14:50:24 -0400
In-Reply-To: <CAJvTdKkuQfOYZ49h4psmE7VJKVw3XWswSuLjL2m+hovRY6OSkw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>

We have in the past had ACPICA users that wished to terminate and later restart (Novell). In any case, we advertise this as a feature, so it should work.


> -----Original Message-----
> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Wednesday, June 12, 2013 10:48 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi; Tomasz
> Nowicki
> Subject: Re: [PATCH 11/16] ACPICA: Clear events initialized flag upon
> event component termination
> 
> On Fri, Jun 7, 2013 at 9:00 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >
> > Clear this flag to allow clean startup and even double termination.
> > ACPICA BZ 1013. Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> The patch looks logically correct, but I'm wondering what use-case made it
> necessary.  Do you have a system where you disable ACPI and then disable
> ACPI again?
> 
> BTW. it looks like we don't check for this flag being FALSE when we
> initialize, so I suppose if you had the case where you enable, disable,
> and then re-enable ACPI mode, that would already work -- though I don't
> know if anybody has ever done that.
> 
> Reviewed-by: Len Brown <len.brown@intel.com>
