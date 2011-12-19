From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [Xen-devel] [PATCH 4/8] ACPI: processor: Don't setup cpu idle driver and handler when we do not want them.
Date: Mon, 19 Dec 2011 10:26:45 -0400
Message-ID: <20111219142645.GC27772@andromeda.dapyr.net>
References: <1322673664-14642-1-git-send-email-konrad.wilk@oracle.com> <1322673664-14642-5-git-send-email-konrad.wilk@oracle.com> <20111216213618.GB9832@phenom.dumpdata.com> <4EEF12DD.2020308@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from andromeda.dapyr.net ([206.212.254.10]:39950 "EHLO
	andromeda.dapyr.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab1LSO1G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Dec 2011 09:27:06 -0500
Content-Disposition: inline
In-Reply-To: <4EEF12DD.2020308@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: liang tang <liang.tang@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jeremy@goop.org, xen-devel@lists.xensource.com, Ian.Campbell@citrix.com, konrad@kernel.org, mike.mcclurg@citrix.com, stefan.bader@canonical.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, Dec 19, 2011 at 06:33:01PM +0800, liang tang wrote:
> On 2011-12-17 5:36, Konrad Rzeszutek Wilk wrote:
> >On Wed, Nov 30, 2011 at 12:21:00PM -0500, Konrad Rzeszutek Wilk wrote:
> >>From: Kevin Tian<kevin.tian@intel.com>
> >>
> >>This patch inhibits processing of the CPU idle handler if it is not
> >>set to the appropiate one. This is needed by the Xen processor driver
> >>which, while still needing processor details, wants to use the 
> >>default_idle
> >>call (which makes a yield hypercall).
> >Which I think is not required anymore with the 
> >d91ee5863b71e8c90eaf6035bff3078a85e2e7b5
> >(cpuidle: replace xen access to x86 pm_idle and default_idle) and
> >62027aea23fcd14478abdddd3b74a4e0f5fb2984
> >(cpuidle: create bootparam "cpuidle.off=1")
> >
> >Liang, can you double-check that please?
> >
> Hi,Konrad
> I just read the code ,I think  don't need that code too. I will double 
> check tomorrow.

Great! Thanks!
