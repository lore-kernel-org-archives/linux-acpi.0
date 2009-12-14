From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 5/5 -v2] acpi, apei, Document for APEI
Date: Mon, 14 Dec 2009 16:44:55 +0800
Message-ID: <1260780295.12561.118.camel@yhuang-dev.sh.intel.com>
References: <1260429424.15264.397.camel@yhuang-dev.sh.intel.com>
	 <200912110958.29319.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29378 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbZLNIo6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2009 03:44:58 -0500
In-Reply-To: <200912110958.29319.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, 2009-12-12 at 00:58 +0800, Bjorn Helgaas wrote: 
> On Thursday 10 December 2009 12:17:04 am Huang Ying wrote:
> > Add document for APEI, including kernel parameters and EINJ debug file
> > sytem interface.
> 
> From a stylistic point of view, I think it's better if the
> documentation is added by the same patch that adds the functionality.
> Having them in separate patches means there's a point in time where
> the tree contains the functionality but not the documentation, or
> vice versa.

Sounds reasonable, I will change this.

Best Regards,
Huang Ying

