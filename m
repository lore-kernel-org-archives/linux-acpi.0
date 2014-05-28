From: Borislav Petkov <bp@alien8.de>
Subject: Re: new trace output format
Date: Wed, 28 May 2014 18:23:31 +0200
Message-ID: <20140528162331.GE17196@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1401247938-22125-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:52422 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003AbaE1QXf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 May 2014 12:23:35 -0400
Content-Disposition: inline
In-Reply-To: <1401247938-22125-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Tue, May 27, 2014 at 11:32:17PM -0400, Chen, Gong wrote:
> Hi, Boris
> 
> Here is the new output format:
> 
>           <idle>-0     [000] d.h.   242.340120: extlog_mem_event: 1 corrected error: unknown DIMM location: Memriser1 CHANNEL A DIMM 0 physical addr: 0000000441a07000 (mask lsb: ff), node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 32336 column: 1056 FRU: 00000000-0000-0000-0000-000000000000
>           <idle>-0     [000] d.h.   349.380406: extlog_mem_event: 2 corrected error: unknown DIMM location: Memriser1 CHANNEL A DIMM 0 physical addr: 00000004416ae000 (mask lsb: ff), node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 31802 column: 1064 FRU: 00000000-0000-0000-0000-000000000000
> 
> I add extra "physical addr:" as prefix. If you don't like it, please feel free to remove it.

That's fine - it is not part of the error record anyway.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
