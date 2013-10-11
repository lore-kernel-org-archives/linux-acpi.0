From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/8] ACPI, APEI, CPER: Add UEFI 2.4 support for memory
 error
Date: Fri, 11 Oct 2013 17:41:53 +0200
Message-ID: <20131011154153.GI5925@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-6-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48284 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298Ab3JKPl7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Oct 2013 11:41:59 -0400
Content-Disposition: inline
In-Reply-To: <1381473166-29303-6-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Oct 11, 2013 at 02:32:43AM -0400, Chen, Gong wrote:
> In latest UEFI spec(by now it is 2.4) memory error definition
> for CPER (UEFI 2.4 Appendix N Common Platform Error Record)
> adds some new fields. These fields help people to locate
> memory error on actual DIMM location.
> 
> Original-author: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
