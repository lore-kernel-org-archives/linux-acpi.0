From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of
 ghes_do_proc
Date: Thu, 19 Apr 2018 09:57:08 -0500
Message-ID: <8f467611-16a1-8fe7-ea12-e2e29023e4e8@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-3-mr.nuke.me@gmail.com> <20180418175201.GI4795@pd.tnic>
 <5f26275c-5896-c552-69c4-78e5aaaa6558@gmail.com>
 <20180419143018.GC3600@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419143018.GC3600@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org, mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
List-Id: linux-acpi@vger.kernel.org



On 04/19/2018 09:30 AM, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 09:19:03AM -0500, Alex G. wrote:
>> On the other side, you lose readability as soon as you get a few more
>> handlers and the function becomes too long.
> 
> No you don't - you split it properly.

And that was the motivation behind my splitting it in this patch.

>> And more importantly, you lose generality: it's not obvious that
>> there's ghes_edac_report_mem_error() which too wide a context.
> 
> I don't understand what that means.

My apologies, sometimes my thought is too far ahead of my typing
fingers. For the purpose of handling _one_ error, you need the CPER
entry for that one error -- narrow context. You don't need the entire
GHES structure -- wide context. Individual handlers should not be able
to access the entire ghes.

When the handlers are restricted to a common signature --which doesn't
include ghes--, it's obvious when functions try to bite more than they
can chew.

Alex
