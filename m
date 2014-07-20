From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] APEI, GHES: Cleanup unnecessary function for
 lock-less list
Date: Sun, 20 Jul 2014 10:01:13 +0200
Message-ID: <20140720080113.GA8849@pd.tnic>
References: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
 <1405478082-30757-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:55225 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbaGTIBR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jul 2014 04:01:17 -0400
Content-Disposition: inline
In-Reply-To: <1405478082-30757-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Jul 15, 2014 at 10:34:40PM -0400, Chen, Gong wrote:
> We have provided a reverse function for lock-less list so delete
> uncessary codes.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
