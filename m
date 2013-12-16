From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Mon, 16 Dec 2013 18:55:51 +0100
Message-ID: <20131216175551.GD9683@pd.tnic>
References: <20131114122956.GE13376@pd.tnic>
 <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
 <20131216141906.GC4922@pd.tnic>
 <20131216143934.GB8397@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51439 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754565Ab3LPRzy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Dec 2013 12:55:54 -0500
Content-Disposition: inline
In-Reply-To: <20131216143934.GB8397@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

On Mon, Dec 16, 2013 at 09:39:34AM -0500, Chen, Gong wrote:
> erst record id cache is implemented in the memory to increase the
> access speed via caching ERST content, so it doesn't matter with
> firmware access.

So what's with the memcpy in __erst_record_id_cache_add_one()?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
