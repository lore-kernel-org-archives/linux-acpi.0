From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to ghes_cper_severity()
Date: Tue, 22 May 2018 20:13:22 +0200
Message-ID: <CAJZ5v0hOC5P79OGAfutLcWzRuh+r9wrf2i3LOVs5VfGqbmoitA@mail.gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com> <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com> <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 22, 2018 at 3:38 PM, Alex G. <mr.nuke.me@gmail.com> wrote:
>
>
> On 05/22/2018 03:55 AM, Rafael J. Wysocki wrote:
>> On Mon, May 21, 2018 at 3:49 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>>> ghes_severity() is a misnomer in this case, as it implies the severity
>>> of the entire GHES structure. Instead, it maps one CPER value to a
>>> GHES_SEV* value. ghes_cper_severity() is clearer.
>>
>> It looks like the *real* reason for this change is that you
>> re-introduce ghes_severity() as a different function in the second
>> patch.
>
> /me holds fist at Borislav
>
>> There are a couple of reasons to avoid that, one of them being that
>> people will now have to remember what the function did in which kernel
>> versions.
>
> So?
>
>> Also, the current name is good enough IMO,
>
> Two other reviewers were extremely confused by the vague name, so no,
> this is not good enough.

Of course, you are free to have a differing opinion and I don't have
to convince you about my point.  You need to convince me about your
point to get the patch in through my tree, which you haven't done so
far.

>> so I'm not going to apply this patch.
