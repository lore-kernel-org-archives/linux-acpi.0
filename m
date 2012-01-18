From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: Re: [patch 3/3] drivers/idle/intel_idle.c: remove redundant
 local_irq_disable() call
Date: Wed, 18 Jan 2012 08:15:25 +0800
Message-ID: <1326845725.1872.1.camel@ymzhang>
References: <20120110234821.E8BF5100270@wpzn3.hot.corp.google.com>
	 <4F0DB1F0.1060408@linux.vnet.ibm.com>  <201201171322.51602.trenn@suse.de>
Reply-To: yanmin_zhang@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52633 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab2ARAPk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 19:15:40 -0500
In-Reply-To: <201201171322.51602.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, lenb@kernel.org, mingmingx.zhang@intel.com, shaohua.li@intel.com

On Tue, 2012-01-17 at 13:22 +0100, Thomas Renninger wrote:
> On Wednesday, January 11, 2012 04:59:44 PM Srivatsa S. Bhat wrote:
> > On 01/11/2012 05:18 AM, akpm@linux-foundation.org wrote:
> ...
> > > [akpm@linux-foundation.org: add comment]
> > > Signed-off-by: mzha38X <mingmingx.zhang@intel.com>
> > 
> >                  ^^^^^^^
> > Are nicknames acceptable? AFAIK, real names are preferred...
> Not perfect, but as an Intel address is used, it
> shouldn't matter.
> Signed-off-by: mingmingx.zhang@intel.com
> would work as well: it's not anonymous.
> I'll use: Mingming Zhang <mingmingx.zhang@intel.com>
> (most google hits) when reposting.
Thomas,

Thanks for your kind reminder. Mingming just sent his first patch to
LKML and he would pay more attention next time.

Yanmin



