From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 02/28] ACPICA: Linuxize: Replace __FUNCTION__ with
 __func__.
Date: Thu, 25 Jun 2015 00:24:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802733BFE@SHSMSX101.ccr.corp.intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
 <cover.1435114811.git.lv.zheng@intel.com>
 <9572a1ad1d35f3c68979610a389063813fd2d2c5.1435114811.git.lv.zheng@intel.com>
 <20150624125559.GA8144@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29173 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbbFYAYz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2015 20:24:55 -0400
In-Reply-To: <20150624125559.GA8144@infradead.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Wednesday, June 24, 2015 8:56 PM
> 
> On Wed, Jun 24, 2015 at 11:02:03AM +0800, Lv Zheng wrote:
> > ACPICA commit cb3d1c79f862cd368d749c9b8d9dced40111b0d0
> >
> > __FUNCTION__ is MSVC only, in Linux, it is __func__. Lv Zheng.
> >
> > In ACPICA, this is achieved by string replacement in release script and
> > this patch contains the source code difference between the Linux upstream
> > and ACPICA that is caused by the back porting.
> 
> __func__ is in C99 and never.  __FUNCTION__ is an old extension supported
> by various compilers.

This patch description is used in ACPICA upstream.
For ACPICA code base, __FUNCTION__ is only used for its MSVC builds.
And __func__ is converted from __FUNCTION__ by the linuxize release script.

See the original commit here:
https://github.com/acpica/acpica/commit/cb3d1c79

So this is simply an automated release output.
Without this merged, source code differences between Linux upstream and ACPICA upstream will hurt the automation.

Thanks and best regards
-Lv
