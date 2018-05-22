From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Date: Tue, 22 May 2018 08:38:39 -0500
Message-ID: <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 05/22/2018 03:55 AM, Rafael J. Wysocki wrote:
> On Mon, May 21, 2018 at 3:49 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>> ghes_severity() is a misnomer in this case, as it implies the severity
>> of the entire GHES structure. Instead, it maps one CPER value to a
>> GHES_SEV* value. ghes_cper_severity() is clearer.
> 
> It looks like the *real* reason for this change is that you
> re-introduce ghes_severity() as a different function in the second
> patch.

/me holds fist at Borislav

> There are a couple of reasons to avoid that, one of them being that
> people will now have to remember what the function did in which kernel
> versions. 

So?

> Also, the current name is good enough IMO,

Two other reviewers were extremely confused by the vague name, so no,
this is not good enough.

> so I'm not going to apply this patch.
