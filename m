From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Wed, 16 Apr 2014 15:14:52 +0200
Message-ID: <20140416131452.GD16741@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
 <20140414140514.GD3663@pd.tnic>
 <20140415092442.GC29868@gchen.bj.intel.com>
 <20140415180259.GE4826@pd.tnic>
 <20140416050158.GA11297@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51526 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343AbaDPNO5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2014 09:14:57 -0400
Content-Disposition: inline
In-Reply-To: <20140416050158.GA11297@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Wed, Apr 16, 2014 at 01:01:58AM -0400, Chen, Gong wrote:
> Yes, The sync can be avoided via separating buffers.

But why do we even need to sync? IOW, we can land here from GHES and
EXTLOG, right? So we have two different paths, which means, we need
synchronization.

And yes, separating the buffers by having GHES and EXTLOG hand down
their own char buffers would make the whole thing very clean IMHO and
lockless. So definitely worth a try.

:-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
