From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Wed, 18 Dec 2013 22:13:00 +0100
Message-ID: <20131218211300.GD12222@pd.tnic>
References: <20131217053451.GB11278@gchen.bj.intel.com>
 <1387348249-20014-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:55685 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738Ab3LRVNH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Dec 2013 16:13:07 -0500
Content-Disposition: inline
In-Reply-To: <1387348249-20014-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org

On Wed, Dec 18, 2013 at 01:30:49AM -0500, Chen, Gong wrote:
> We ever used *memcpy* to avoid access alignment issue between
> firmware and OS. Now we can use a better and standard way
> to avoid this issue.
> 
> Because ERST record id cache is implemented in the memory to
> increase the access speed via caching ERST content, so it
> doesn't matter with firmware access. BTW, simplify some
> variable names to avoid the limit of 80 characters per line.
> 
> v4->v3: Add more detail description.
> v3->v2: Fix an evaluation error.
> v2->v1: Make description information clearer.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> Acked-by: Borislav Petkov <bp@suse.de>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
