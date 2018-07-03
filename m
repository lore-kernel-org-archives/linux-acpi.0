From: Ian Campbell <ijc@debian.org>
Subject: Re: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
Date: Tue, 03 Jul 2018 09:44:26 +0100
Message-ID: <1530607466.9841.124.camel@debian.org>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, James Morse <james.morse@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Geoff Levand <geoff@infradead.org>, Riku Voipio <riku.voipio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Salter <msalter@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2018-06-28 at 12:25 +0200, Ard Biesheuvel wrote:
> I understand the desire to keep running these M400s as long as they
> have some life left in them, but the reality is that they are end of
> life already, and not many were manufactured to begin with.

Linux has a long history of supporting such devices so long as there is
someone around willing to keep them running (witness for example how
long x86/voyager lived with just 1 in existence in a motivated
developer's basement, probably some number of entire architectures and
I bet a not insubstantial chunk of the platform support in arch/arm).

> Given how the upstream kernel is aimed at future development,

That might be true in some sense but I don't think it can be said to
extends to "not worried about running on existing hardware".

>  I don't
> think we should fix this in the upstream kernel at all. Distros are
> free to do what they like, of course, and I'm sure RedHat already have
> a fix for this in their downstream kernel. But putting this upstream
> means we will never be able to remove it again,

Quirks are pretty self contained and should be very unobtrusive to the
common code paths though. Also I expect that quirks _can_ be removed
once the platform has actually died in reality (not just no longer
produced) or becomes too much of a burden for other reasons (which AIUI
is what eventually happened to Voyager).

>  which would be
> especially unfortunate given that it is the first ever DMI quirk for
> arm64, which we tried *very* hard to avoid, also because we don't
> initialize the DMI framework as early as x86 does, and so once we open
> the floodgates,

The "flood" is inversely proportional to the quality of the firmware
certification and it isn't too overwhelming on x86, which historically
had next to no certification apart from "runs Windows", so it seems
unlikely to me that on arm64, where some attempts have been made at
validation and test suites from very near the start, that the flood
will be all that overwhelming.

>  we will run into issues where we will need to reorder
> the init sequence to make DMI data available early enough.

> a) DMI quirks will be permitted on arm64
> b) we care about m400 enough to put this quirk in the upstream kernel

In general arm64 Linux is going to need to be able to cope with
firmware in the field which is either rubbish to some degree or which
predates the addition of some support in the kernel and turns out not
to be fully functional when that support is enabled (the latter it
seems being what happened in the m400 case).

So, I think DMI quirks are probably, in reality, inevitable unless you
think firmware authors are going to be infaliable or the
testing/certification suites never has any gaps in it.

Given that, the overhead of then supporting m400 seems pretty trivial.

That said, maybe there are more appropriate mechanisms than DMI on
arm64 for detecting and activating quirks?

Cheers,
Ian.
