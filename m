From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7 REVISION v2] trace, RAS: Add eMCA trace event
 interface
Date: Sun, 22 Jun 2014 18:48:40 +0200
Message-ID: <20140622164839.GB3385@pd.tnic>
References: <20140617020937.GA14404@gchen.bj.intel.com>
 <1403058787-15449-1-git-send-email-gong.chen@linux.intel.com>
 <1403058787-15449-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41538 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbaFVQsu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jun 2014 12:48:50 -0400
Content-Disposition: inline
In-Reply-To: <1403058787-15449-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: rostedt@goodmis.org, tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Tue, Jun 17, 2014 at 10:33:07PM -0400, Chen, Gong wrote:
> Add trace interface to elaborate all H/W error related information.
> 
> v7 -> v6: compact trace info to save trace buffer space.
> v6 -> v5: format adjustment.
> v5 -> v4: Add physical mask(LSB) in trace.
> v4 -> v3: change ras trace dependency rule.
> v3 -> v2: minor adjustment according to the suggestion from Boris.
> v2 -> v1: spinlock is not needed anymore.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Yep, this is starting to look good now:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
