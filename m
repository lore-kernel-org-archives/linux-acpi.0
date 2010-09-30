From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2 1/5] ACPI, APEI, Fix APEI related table size
 checking
Date: Thu, 30 Sep 2010 08:11:46 +0800
Message-ID: <1285805506.6944.4.camel@yhuang-dev>
References: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
	 <1285761235-4751-2-git-send-email-ying.huang@intel.com>
	 <AANLkTi=JkcJiQhxLSmU2vgmrACPSrE16cEhRnxCOr_5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43948 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab0I3ALs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Sep 2010 20:11:48 -0400
In-Reply-To: <AANLkTi=JkcJiQhxLSmU2vgmrACPSrE16cEhRnxCOr_5g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Yinghai,

On Wed, 2010-09-29 at 23:47 +0800, Yinghai Lu wrote:
> On Wed, Sep 29, 2010 at 4:53 AM, Huang Ying <ying.huang@intel.com> wrote:
> > On Huang Ying's machine:
> >
> > erst_tab->header_length == sizeof(struct acpi_table_einj)
> 
> So it seems your system firmware violates the 4.0 spec

Perhaps. :)

But the machine firmware has been released, and we should support as
many machines as possible I think. Do you agree?

Best Regards,
Huang Ying


