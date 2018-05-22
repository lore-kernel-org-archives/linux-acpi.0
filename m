From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Date: Tue, 22 May 2018 09:39:15 -0500
Message-ID: <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180522135015.GF5512@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 05/22/2018 08:50 AM, Borislav Petkov wrote:
> On Tue, May 22, 2018 at 08:38:39AM -0500, Alex G. wrote:
>>> It looks like the *real* reason for this change is that you
>>> re-introduce ghes_severity() as a different function in the second
>>> patch.
>>
>> /me holds fist at Borislav
> 
> That was a misunderstanding with Rafael and me - we fixed it on IRC.

You mean to say this whole time I've been struggling to write emails,
there was an IRC?

> But this is not the real problem with your approach - it is the marking
> of all PCIe errors as recoverable, regardless of the signature. That's a
> no-no, IMO.

No, the problem is with the current approach, not with mine. The problem
is trying to handle the error outside of the existing handler. That's a
no-no, IMO.

Alex
