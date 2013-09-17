From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 07/14] ACPICA: Add support for host-installed SCI
 handlers.
Date: Tue, 17 Sep 2013 17:47:08 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEED96F@ORSMSX103.amr.corp.intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<685cb618c64dcf124eb49058472299d3da3d1894.1377844863.git.lv.zheng@intel.com>
 <CAJvTdKm2bpvofU8tiZGBFjY7cKn0vQgC==3K=QgPXwDnE14SjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48690 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab3IQRrK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Sep 2013 13:47:10 -0400
In-Reply-To: <CAJvTdKm2bpvofU8tiZGBFjY7cKn0vQgC==3K=QgPXwDnE14SjA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

> -----Original Message-----
> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Monday, September 16, 2013 5:48 PM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> Subject: Re: [PATCH 07/14] ACPICA: Add support for host-installed SCI
> handlers.
> 
> On Thu, Sep 12, 2013 at 4:55 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> > This change adds support to allow hosts to install System Control
> > Interrupt handlers. Certain ACPI functionality requires the host to
> > handle raw SCIs. For example, the "SCI Doorbell" that is defined for
> > memory power state support requires the host device driver to handle
> > SCIs to examine if the doorbell has been activated. Multiple SCI
> > handlers can be installed to allow for future expansion.
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

Platform Communication Channel, via the MPST table (new for ACPI 5.0)

When the PCC subchannel responds to the host, it issues an SCI and the host must probe the subchannel for channel status.





> 
> thanks,
> -Len
