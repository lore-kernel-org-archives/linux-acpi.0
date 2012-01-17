From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 3/3] drivers/idle/intel_idle.c: remove redundant local_irq_disable() call
Date: Tue, 17 Jan 2012 13:22:51 +0100
Message-ID: <201201171322.51602.trenn@suse.de>
References: <20120110234821.E8BF5100270@wpzn3.hot.corp.google.com> <4F0DB1F0.1060408@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51478 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743Ab2AQMWy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 07:22:54 -0500
In-Reply-To: <4F0DB1F0.1060408@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org
Cc: akpm@linux-foundation.org, lenb@kernel.org, yanmin_zhang@linux.intel.com, mingmingx.zhang@intel.com, shaohua.li@intel.com

On Wednesday, January 11, 2012 04:59:44 PM Srivatsa S. Bhat wrote:
> On 01/11/2012 05:18 AM, akpm@linux-foundation.org wrote:
...
> > [akpm@linux-foundation.org: add comment]
> > Signed-off-by: mzha38X <mingmingx.zhang@intel.com>
> 
>                  ^^^^^^^
> Are nicknames acceptable? AFAIK, real names are preferred...
Not perfect, but as an Intel address is used, it
shouldn't matter.
Signed-off-by: mingmingx.zhang@intel.com
would work as well: it's not anonymous.
I'll use: Mingming Zhang <mingmingx.zhang@intel.com>
(most google hits) when reposting.

   Thomas
