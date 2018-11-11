From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Sun, 11 Nov 2018 12:57:12 +0100
Message-ID: <c883a2be-e772-2e18-f074-d2ad5f27f42b@redhat.com>
References: <20181103065732.12134-1-jprvita@endlessm.com>
 <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
 <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, pavel@ucw.cz
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, sebastian.reichel@collabora.co.uk, Linux Kernel <linux-kernel@vger.kernel.org>, linux@endlessm.com, =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 11/7/18 5:53 AM, Daniel Drake wrote:
> On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
>> Plus, I don't think "100% charge" is right test for "battery full". At
>> least on thinkpads, there's configuration option, and it is common
>> _not_ to charge batterry above 95% or so (to increase its lifetime).
> 
> Hans also touched on this area in his response:
> 
>> As for this kernel-side fix I do not believe that fixing thus in
>> the kernel is the right thing to do. We try to stay away from
>> heuristics using full_charge_capacity in the kernel since that
>> is not really reliable / deterministic.
> 
> I'm not fully convinced by this argument though.
> 
> The ACPI spec is not very clear on what conditions you should apply to
> decide when the battery is full. Instead, ACPI seems to provide a
> pretty decent amount of data, and the decision about whether to
> interpret that as "battery full" is left for consumers.

Right, but in this case the "discharging" status bit is explicitly
set, to me it feels wrong to report "full", when the firmware
is reporting "discharging" IMHO, at best we are "not charging"
(on AC, below the threshold where a new charge cycle starts) and
that is what we are currently reporting.

Anu heurstics to decide that "not charging" is close enough to full
to report it as full to the user belongs in userspace IMHO.

Anyways this ultimately is Rafael's call. If Rafael is ok with this
patch then I would like to see Pavel's comment addressed and otherwise
it is fine with me.

Note that we will still often get the case where a laptop is charged,
reports full, is unplugged for 5 minutes and then replugged and then
reports a capacity of 97% combined with "not charging", so we will
still need to fix userspace to handle this.

Rafael, what is your take on this?

Regards,

Hans
