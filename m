From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
 error handling
Date: Sat, 21 Dec 2013 13:41:23 +0100
Message-ID: <20131221124123.GB4991@pd.tnic>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
 <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
 <52946433.1010403@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41830 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab3LUMlZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Dec 2013 07:41:25 -0500
Content-Disposition: inline
In-Reply-To: <52946433.1010403@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, linux-acpi@vger.kernel.org

On Tue, Nov 26, 2013 at 02:34:51PM +0530, Naveen N. Rao wrote:
> On 11/25/2013 12:45 PM, Chen, Gong wrote:
> >Cleanup the logic for function ghes_handle_memory_failure. Just
> >make it simpler and cleaner.
> >
> >v2 -> v1: fix a compile error & some minor changes.
> >
> >Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> 
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
