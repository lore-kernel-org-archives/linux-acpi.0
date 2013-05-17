From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] ACPI/APEI: Add parameter check before error injection
Date: Fri, 17 May 2013 11:07:16 +0200
Message-ID: <20130517090716.GA23035@pd.tnic>
References: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
 <1368671347-22415-2-git-send-email-gong.chen@linux.intel.com>
 <20130516110503.GB31373@pd.tnic>
 <20130517050932.GA30122@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59787 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab3EQJHY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 May 2013 05:07:24 -0400
Content-Disposition: inline
In-Reply-To: <20130517050932.GA30122@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, linux-acpi@vger.kernel.org

On Fri, May 17, 2013 at 01:09:32AM -0400, Chen Gong wrote:
> IMHO, I don't think your attached patch has obvious improvment. I
> paste my updated patch here and please continue to review. I will send
> updated patch based on your further review.

I already did my review. Having a bool checkparam and querying it
straight afterwards is clumsy code. Also you're adding a redundant
definiton of PAGE_MASK even though it already exists in the kernel.
Maybe you should've grepped the sources first...

Not to mention that this check seems wrong:

	((param2 & PAGE_MASK) != PAGE_MASK)

But hey, I have better things to do instead of wasting time with this.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
