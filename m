From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Wed, 16 Apr 2014 15:28:18 +0200
Message-ID: <20140416132818.GE16741@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
 <20140415091944.GB29868@gchen.bj.intel.com>
 <20140415180553.GF4826@pd.tnic>
 <20140416062323.GB11297@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33906 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161002AbaDPN2X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2014 09:28:23 -0400
Content-Disposition: inline
In-Reply-To: <20140416062323.GB11297@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Wed, Apr 16, 2014 at 02:23:23AM -0400, Chen, Gong wrote:
> We have different CPER error type. For example, for processor error type,
> it has following definition:
> 
> struct cper_sec_proc_generic {
>         __u64   validation_bits;
>         __u8    proc_type;
>         __u8    proc_isa;
>         __u8    proc_error_type;
>         __u8    operation;
>         __u8    flags;
>         __u8    level;
>         __u16   reserved;
>         __u64   cpu_version;
>         char    cpu_brand[128];
>         __u64   proc_id;
>         __u64   target_addr;
>         __u64   requestor_id;
>         __u64   responder_id;
>         __u64   ip;
> };
> 
> If we want to show it in string format, 256 bytes should be not enough. But
> by now we don't use this macro for processor error type so I will shrink it
> to 256 bytes and add a comment for it.

Yeah, we don't have to always adhere to the spec if we feel it doesn't
make any sense. A lot of those fields above are purely useless and we
shouldn't carry them blindly to the outside.

For example, we don't need to carry cpu_brand[128] to the outside for
*every* error. Who even came up with this crap, is beyond me??? It's
like the cpu changes brand on every other error or what? You harvest
this info only *once* from /proc/cpuinfo. cpu_version too. And so on and
so on...

Please sanity-check stuff like that before hardcoding it into the
tracepoint. If it is in the spec it doesn't always mean it makes sense.
We need to carry out only the minimum amount of information of each
error which is actually getting used in userspace, for additional RAS
actions. Carrying fat blobs just because the spec says so is simply
wrong.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
