From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
 error handling
Date: Tue, 26 Nov 2013 08:23:35 +0100
Message-ID: <20131126072335.GA20917@pd.tnic>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
 <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
 <20131126065456.GB26098@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59607 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193Ab3KZHXk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Nov 2013 02:23:40 -0500
Content-Disposition: inline
In-Reply-To: <20131126065456.GB26098@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com, linux-acpi@vger.kernel.org

On Tue, Nov 26, 2013 at 01:54:57AM -0500, Chen, Gong wrote:
> In this patch so-called cleanup includes an implied PFN check for UC
> error but missed in current codes.

Right, I was about to look at it. You probably should add this to the
commit message so that it is clear.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
