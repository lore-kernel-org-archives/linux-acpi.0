From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 07/14] ACPICA: Add support for host-installed SCI
 handlers.
Date: Tue, 17 Sep 2013 01:07:18 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802463F85@SHSMSX101.ccr.corp.intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<685cb618c64dcf124eb49058472299d3da3d1894.1377844863.git.lv.zheng@intel.com>
 <CAJvTdKm2bpvofU8tiZGBFjY7cKn0vQgC==3K=QgPXwDnE14SjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18283 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437Ab3IQBHY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 21:07:24 -0400
In-Reply-To: <CAJvTdKm2bpvofU8tiZGBFjY7cKn0vQgC==3K=QgPXwDnE14SjA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Tuesday, September 17, 2013 8:48 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> Subject: Re: [PATCH 07/14] ACPICA: Add support for host-installed SCI handlers.
> 
> On Thu, Sep 12, 2013 at 4:55 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> > This change adds support to allow hosts to install System Control
> > Interrupt handlers. Certain ACPI functionality requires the host
> > to handle raw SCIs. For example, the "SCI Doorbell" that is defined
> > for memory power state support requires the host device driver to
> > handle SCIs to examine if the doorbell has been activated. Multiple
> > SCI handlers can be installed to allow for future expansion.
> > Debugger support is included.
> > Lv Zheng, Bob Moore. ACPICA BZ 1032.
> >
> > Buglink: http://bugs.acpica.org/show_bug.cgi?id=1032
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> 
> 
> The bug report references PCC -- is that _PCC events, or Processor
> Clocking Control?
> We think we support both of those before this patch -- so how can PCC
> require this change?

The PCC here refers to Platform Communications Channel (PCC) which is defined in the Chap 14 of the ACPI specification.
It said that "the PCC completion check is not factored into the ACPICA in upstream kernel yet".
So the installable SCI handlers are expected.

Thanks
-Lv

> 
> thanks,
> -Len
