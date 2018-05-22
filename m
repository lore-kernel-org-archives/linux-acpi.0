From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Date: Tue, 22 May 2018 10:22:19 -0500
Message-ID: <9b3823fc-a660-a619-68b9-43b879f81b05@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
 <20180522145426.GG5512@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180522145426.GG5512@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 05/22/2018 09:54 AM, Borislav Petkov wrote:
> On Tue, May 22, 2018 at 09:39:15AM -0500, Alex G. wrote:
>> No, the problem is with the current approach, not with mine. The problem
>> is trying to handle the error outside of the existing handler. That's a
>> no-no, IMO.
> 
> Let me save you some time: until you come up with a proper solution for
> *all* PCIe errors so that the kernel can correctly decide what to do for
> each error based on its actual severity, consider this NAKed.

I do have a proper solution for _all_ PCIe errors. In fact, we discussed
several valid approaches already.

> I don't care about outside or inside of the handler 

I do. I have a handler that can handle (no pun intended) errors. I want
to use the same code path in native and GHES cases. If I allow ghes.c to
take different decisions than what aer_do_recovery() would, I've failed.

>- this thing needs to be done properly 

Exactly!

> and not just to serve your particular use case of
> abrupt removal of devices causing PCIe errors, and punish the rest.

I think you're confused about what I'm actually trying to do. Or maybe
you're confused about how PCIe errors work. That's understandable. PCIe
uses the term "fatal" for errors that may make the link unusable, and
which may require a link reset, and in most other specs "fatal" means
"on fire". I understand your confusion, and I hope I cleared it up.

You're trying to make the case that surprise removal is my only concern
and use case, because that's the example that I gave. It makes your
argument stronger, but it's wrong. You don't know our test setup, and
all the things I'm testing for, and whenever I try to tell you, you fall
back to the 'surprise removal' example.

I don't know why you'd think Dell would pay me to work on this if I were
to allow things like silent data corruption to creep in. This isn't a
traditional company from Redmond, Washington.

> I especially don't want to have the case where a PCIe error is *really*
> fatal and then we noodle in some handlers debating about the severity
> because it got marked as recoverable intermittently and end up causing
> data corruption on the storage device. Here's a real no-no for ya.

I especially don't want a kernel maintainer who hasn't even read the
recovery handler (let alone the spec around which the handler was
written) tell me how the recovery handler works and what it's supposed
to do (see, I can be an ass).
PCIe errors really are fatal. They might need to unload the driver and
remove the device. But somebody set the questionable policy that
"fatal"=="panic", and that is completely inappropriate for a larger
class of errors -- PCIe happens to be the easiest example to pick on.

And even you realize that the argument that a panic() will somehow
prevent data corruption is complete noodle sauce.

Alex
