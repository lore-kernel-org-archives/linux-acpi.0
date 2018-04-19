From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of
 ghes_do_proc
Date: Thu, 19 Apr 2018 10:46:15 -0500
Message-ID: <b9887ae1-8d7e-cfff-3933-d9358283a3c4@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-3-mr.nuke.me@gmail.com> <20180418175201.GI4795@pd.tnic>
 <5f26275c-5896-c552-69c4-78e5aaaa6558@gmail.com>
 <20180419143018.GC3600@pd.tnic>
 <8f467611-16a1-8fe7-ea12-e2e29023e4e8@gmail.com>
 <20180419152933.GD3600@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419152933.GD3600@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org, mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
List-Id: linux-acpi@vger.kernel.org



On 04/19/2018 10:29 AM, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 09:57:08AM -0500, Alex G. wrote:
>> And that was the motivation behind my splitting it in this patch.
> 
> By "split" I don't mean add a function pointer which gets selected and
> then called - if the function becomes too long, you simply split the
> function body properly.

The bulk of the function is the if/else mapping from UUID to error
handler. I don't see how that can be easily split up, hence why I
originally resorted to the mapping. As you said, we'll keep it simple at
first.

>> You don't need the entire GHES structure -- wide context. Individual
>> handlers should not be able to access the entire ghes.
> 
> But you remove the @ghes argument in patch 1. So what are we even
> talking about?

You could say, by convention, handlers shouldn't access ghes directly,
but that is not obvious when @ghes is in scope. The reason I bring it up
is that, if [1/4] ends up being unneeded, then I will drop it from the
series.

Alex
