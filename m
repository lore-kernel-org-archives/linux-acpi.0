From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Sat, 16 Nov 2013 12:48:03 +0100
Message-ID: <20131116114803.GG18306@pd.tnic>
References: <20131114122956.GE13376@pd.tnic>
 <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42332 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab3KPLsd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Nov 2013 06:48:33 -0500
Content-Disposition: inline
In-Reply-To: <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org

On Fri, Nov 15, 2013 at 12:45:56AM -0500, Chen, Gong wrote:
> We ever used *memcpy* to avoid access alignment issue between
> firmware and OS. Now we can use a better and standard way
> to avoid this issue. In the meanwhile, simplify some variable names
> to avoid the limit of 80 characters per line and use structure
> assignment instead of unnecessary memcpy. No functional changes.
> 
> v3->v2: Fix an evaluation error.
> v2->v1: Make description information clearer.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
