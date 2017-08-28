From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4] acpi: apei: fix the wrong iteration of generic error status block
Date: Mon, 28 Aug 2017 22:57:22 +0200
Message-ID: <5043352.d7u3xW1eZT@aspire.rjw.lan>
References: <1502971638-31670-1-git-send-email-gengdongjiu@huawei.com> <20170817114349.uxtossvvaccuwy5g@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53210 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751182AbdH1VGB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Aug 2017 17:06:01 -0400
In-Reply-To: <20170817114349.uxtossvvaccuwy5g@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>, Dongjiu Geng <gengdongjiu@huawei.com>
Cc: will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, tbaicar@codeaurora.org, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

On Thursday, August 17, 2017 1:43:49 PM CEST Borislav Petkov wrote:
> On Thu, Aug 17, 2017 at 08:07:18PM +0800, Dongjiu Geng wrote:
> > The revision 0x300 generic error data entry is different
> > from the old version, but currently iterating through the
> > GHES estatus blocks does not take into account this difference.
> > This will lead to failure to get the right data entry if GHES
> > has revision 0x300 error data entry.
> > 
> > Update the GHES estatus iteration to properly increment using
> > iteration macro,
> 
> This is not what I meant - I meant:
> 
> "Update the GHES estatus iteration macro to properly increment using
> acpi_hest_get_next(), and ..."
> 
> But you don't need to send another version.
> 
> Rafael, please correct that when applying, instead.

Well, I think I did that. :-)

Anyway, applied.

Thanks!

