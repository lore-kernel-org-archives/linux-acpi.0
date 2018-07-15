From: =?UTF-8?B?Si4gQWd1c3TDrW4gVmVnYS1GcsOtYXM=?=
        <agustin.vega.frias@gmail.com>
Subject: Re: [RFC V4 0/3] arm_pmu: acpi: variant support and QCOM Falkor extensions
Date: Sun, 15 Jul 2018 15:35:45 -0500
Message-ID: <CAGbRU0QLSpNEtcryuPPZE98zAo7peEmcDqcQiLi1zO6cfKML2A@mail.gmail.com>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org> <20180713153318.GB3049@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713153318.GB3049@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Phani Pabba <pabba@codeaurora.org>, Richard Ruigrok <rruigrok@codeaurora.org>, Vijaya Kilari <vkilari@codeaurora.org>, Jeff Hugo <jhugo@codeaurora.org>, Rahul Ramasubramanian <rahulr@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Hi Will,

On Fri, Jul 13, 2018 at 10:33 AM, Will Deacon <will.deacon@arm.com> wrote:

[snip]

> I'm mostly ok with this approach, but I have a concern with the way in wh=
ich
> the sysfs interface for carving up the config fields is implemented. If t=
his
> is intended to be a strict extension to the armv8 pmu architecture, then =
I
> don't think you should be overriding the attr_groups entirely. Rather, yo=
u
> should be taking the attr_groups from pmuv3 and then extending them in a =
way
> which avoids overlapping field allocations by construction.
>
> As it stands, you already have an overlap between the pcc bit and the
> chained counter bit which Suzuki has implemented and it will be very easy=
 to
> introduce API breakage if we don't enforce this as part of the design.
>
> Will

FYI, I left Qualcomm on July 6, one of my former colleagues will submit
new iterations of this series. I will continue to comment on this and futur=
e
patchsets as a courtesy to my former colleagues and the community.

Thanks for pointing out the sysfs issue. My suggestion on how to address it=
 is:

1. Reserve config and config1 for architectural format attributes and
   config2 for extension format attributes.
2. Add a struct attribute ** parameter to the extension init function so
   extensions can return the new attributes.
3. The extension framework code in arm_pmu_acpi.c can then allocate a new
   attribute array to contain the base and extension attributes and ensure
   all the new attributes are on config2.

Though a more elaborate approach can be implemented to find conflicts in
bit usage within config fields, it would require much more code for a
relatively simple problem. Thoughts?

Thanks,
Agust=C3=ADn
