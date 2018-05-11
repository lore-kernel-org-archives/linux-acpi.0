From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Date: Fri, 11 May 2018 11:12:24 -0500
Message-ID: <f70e209d-00ec-1969-16de-09d6142668da@gmail.com>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-2-mr.nuke.me@gmail.com> <20180511153947.GC12705@pd.tnic>
 <56d445b2-ace3-6ee2-9699-f2a684518de9@gmail.com>
 <20180511155833.GE12705@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511155833.GE12705@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 05/11/2018 10:58 AM, Borislav Petkov wrote:
> On Fri, May 11, 2018 at 10:45:49AM -0500, Alex G. wrote:
>>
>>
>> On 05/11/2018 10:39 AM, Borislav Petkov wrote:
>>> On Mon, Apr 30, 2018 at 04:33:51PM -0500, Alexandru Gagniuc wrote:
>>>> ghes_severity() is a misnomer in this case, as it implies the severity
>>>> of the entire GHES structure. Instead, it maps one CPER value to a
>>>> monotonically increasing number.
>>>
>>> ... as opposed to CPER severity which is something else or what is this
>>> formulation trying to express?
>>>
>>
>> CPER madness goes like this:
> 
> Let's slow down first. Why is it a "CPER madness"? Maybe this is clear
> in your head but I'm not in it.
> 
>> 	0 - Recoverable
>> 	1 - Fatal
>> 	2 - Corrected
>> 	3 - None
> 
> If you're quoting this:

I'm quoting ACPI 6.2, Table 18-381 Generic Error Data Entry, though I'm
certain they got that from the efi spec.

> enum {
>         CPER_SEV_RECOVERABLE,
>         CPER_SEV_FATAL,
>         CPER_SEV_CORRECTED,
>         CPER_SEV_INFORMATIONAL,
> };
> 
> that last 3 is informational.
> 
>> As you can see, the numbering was created by crackmonkeys. GHES_* is an
>> internal enum that goes up in order of severity, as you'd expect.
> 
> So what are you trying to tell me - that those CPER numbers are not
> increasing?!
> 
> Why does that even matter?

Because the GHES structure uses CPER values, but all the code is written
to use GHES_SEV_ values. GHES_SEV_ is a made up enum, specifically for
linux.

Sure, the return in ghes_sec_pcie_severity() should say
GHES_SEV_RECOVERABLE, but that is a Freudian slip rather than
intentional typing. Thank you for catching that :)

Alex
