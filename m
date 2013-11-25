From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for memory
 error handling
Date: Mon, 25 Nov 2013 18:13:49 +0100
Message-ID: <20131125171349.GI6782@pd.tnic>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42693 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493Ab3KYRNx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Nov 2013 12:13:53 -0500
Content-Disposition: inline
In-Reply-To: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com, linux-acpi@vger.kernel.org

On Mon, Nov 25, 2013 at 02:15:00AM -0500, Chen, Gong wrote:
> Usually SCI is employed to handle corrected error, especially
> for memory corrected error but in fact SCI still can be used
> to handle any error like memory uncorrected error even fatal
> error if BIOS enable it. For this kind of situation, it
> should be logged, too.
> 
> v2 -> v1: make the event record more precisely
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Looks ok to me.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
