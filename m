From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of
 ghes_do_proc
Date: Thu, 19 Apr 2018 16:30:19 +0200
Message-ID: <20180419143018.GC3600@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-3-mr.nuke.me@gmail.com>
 <20180418175201.GI4795@pd.tnic>
 <5f26275c-5896-c552-69c4-78e5aaaa6558@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f26275c-5896-c552-69c4-78e5aaaa6558@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org, mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 19, 2018 at 09:19:03AM -0500, Alex G. wrote:
> On the other side, you lose readability as soon as you get a few more
> handlers and the function becomes too long.

No you don't - you split it properly.

> And more importantly, you lose generality: it's not obvious that
> there's ghes_edac_report_mem_error() which too wide a context.

I don't understand what that means.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
