From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 UPDATE-2 3/3] ACPI/APEI/EINJ: Allow memory error
 injection to NVDIMM
Date: Fri, 30 Oct 2015 15:47:30 +0100
Message-ID: <20151030144730.GG20952@pd.tnic>
References: <1445894544-21382-1-git-send-email-toshi.kani@hpe.com>
 <20151030094029.GC20952@pd.tnic>
 <1446212931.20657.161.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34907 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbbJ3Orn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Oct 2015 10:47:43 -0400
Content-Disposition: inline
In-Reply-To: <1446212931.20657.161.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>, rjw@rjwysocki.net
Cc: tony.luck@intel.com, akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 30, 2015 at 07:48:51AM -0600, Toshi Kani wrote:
> Yes, the brackets are not necessary. I put them as self-explanatory of
> the precedence. Shall I remove them, and send you an updated patch?

Not necessary, I have my high hopes that Rafael can remove them when
applying :-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
