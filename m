From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2 1/5] ACPI, APEI, Fix APEI related table size
 checking
Date: Thu, 30 Sep 2010 08:25:34 +0800
Message-ID: <1285806334.6944.8.camel@yhuang-dev>
References: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
	 <1285761235-4751-2-git-send-email-ying.huang@intel.com>
	 <alpine.LFD.2.00.1009291400590.3855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60826 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab0I3AZ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Sep 2010 20:25:57 -0400
In-Reply-To: <alpine.LFD.2.00.1009291400590.3855@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Len,

On Thu, 2010-09-30 at 02:01 +0800, Len Brown wrote:
> > Originally-by: Yinghai Lu <yinghai@kernel.org>
> 
> BTW.
> 
> If the patch is substantially the same as the original,
> then the method to credit the original author is to
> start the patch body with:
> 
> From: Yinghai Lu <yinghai@kernel.org>
> 
> and you can choose to note your changes in the signed-off part,
> like akpm typically does, or not.

Thanks for remaining.

I changes the logic in original patch, and don't know whether Yinghai
agree with me. So uses Originally-by: here. If I just do some minor
fixes, I will use From:

Best Regards,
Huang Ying


