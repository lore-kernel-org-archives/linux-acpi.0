From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION] 4.17 failed to probe ACPI PnP
Date: Tue, 19 Jun 2018 10:28:42 +0200
Message-ID: <CAJZ5v0hidPav5kvTW05e0k5mouFyiUiyUW50=fDqVphbEBjQaA@mail.gmail.com>
References: <s5h8t7bfgnq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h8t7bfgnq.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Noah Davis <noahadvs@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 19, 2018 at 8:12 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Hi,
>
> there seems a regression regarding the probe of ACPI PnP devices.
> The detailed logs are found in openSUSE bugzilla:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1098074

But that's on this particular machine, not in general, right?

At least I don't see this on any of the systems in my office.

> In short, since 4.17, the laptop keyboard is lost on ASUS K501UW.
> Comparing the kernel messages and other logs indicates that the
> complete lost of ACPI PnP devices:
>
> On 4.16:
> [    0.390244] pnp: PnP ACPI: found 9 devices
>
> On 4.17:
> [    0.263266] pnp: PnP ACPI: found 0 devices
>
> ... and this leads to the failure of PS/2 keyboard detection due to
> the missing PNP030b entry as a result.
>
> Any hints for debugging this are appreciated.

It looks like this may be related to the ACPICA changes that went in
during the 4.17 cycle.

I would try 4.18-rc1 as there is an ACPICA fix in it that may be
related to this in theory.  If that doesn't help, I'd focus on the
ACPICA changes.

Thanks,
Rafael
