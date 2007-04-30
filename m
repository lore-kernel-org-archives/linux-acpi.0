From: Dave Jones <davej@redhat.com>
Subject: Re: ACPI interpreter errors (aer_init)
Date: Sun, 29 Apr 2007 20:40:50 -0400
Message-ID: <20070430004050.GE14857@redhat.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4025DC20B@orsmsx415.amr.corp.intel.com> <200704280231.52809.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422642AbXD3AmO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 20:42:14 -0400
Content-Disposition: inline
In-Reply-To: <200704280231.52809.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, Zhang@d975xbx2, Yanmin <yanmin.zhang@intel.com>, "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Sat, Apr 28, 2007 at 02:31:52AM -0400, Len Brown wrote:

 > On a quick glance, it appears that these messages have been in the aer driver
 > since it was born.
 > Did you run with CONFIG_PCIEAER in 2.6.19 or 2.6.20 and not have them there?
 > 
 > I agree with Bob, as status 5 is AE_NOT_FOUND,
 > it appears that the driver is being overly verbose,
 > even though these appear to all be KERN_DEBUG messages.

See this thread.. 

From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: lenb@kernel.org, us15@os.inf.tu-dresden.de, gregkh@suse.de, davej@redhat.com
Subject: [PATCH] reduce AER init error information

for a patch resolving this.

	Dave

-- 
http://www.codemonkey.org.uk
