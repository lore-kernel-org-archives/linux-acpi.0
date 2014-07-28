From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Mon, 28 Jul 2014 18:00:41 +0100
Message-ID: <20140728170041.GB2576@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
 <5014834.k6eecMddPC@wuerfel>
 <20140728162750.GB32359@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140728162750.GB32359@quad.lixom.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linaro-acpi-private@linaro.org" <linaro-acpi-private@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradea>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 28, 2014 at 05:27:50PM +0100, Olof Johansson wrote:
> On Mon, Jul 28, 2014 at 11:07:50AM +0200, Arnd Bergmann wrote:
> > On Saturday 26 July 2014 19:34:48 Olof Johansson wrote:
> > > On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > > > +Relationship with Device Tree
> > > > +-----------------------------
> > > > +
> > > > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
> > > > +exclusive with DT support at compile time.
> > > > +
> > > > +At boot time the kernel will only use one description method depending on
> > > > +parameters passed from the bootloader.
> > > 
> > > Possibly overriden by kernel bootargs. And as debated for quite a
> > > while earlier this year, acpi should still default to off -- if a DT
> > > and ACPI are both passed in, DT should at this time be given priority.
> > 
> > I think this would be harder to do with the way that ACPI is passed in
> > to the kernel. IIRC, you always have a minimal DT information based on
> > the ARM64 boot protocol, but in the case of ACPI, this contains pointers
> > to the ACPI tables, which are then used for populating the Linux platform
> > devices (unless acpi=disabled is set), while the other contents of the
> > DTB may be present but we skip the of_platform_populate state.
> 
> How can it be harder to do? If you support acpi=off, then you should support
> acpi=on.
> 
> Another alternative would be to have an early fixup that stubs out
> the acpi properties from the DTB unless there's an 'acpi' or 'acpi=on'
> argument on the cmdline. Not quite as tidy a solution, though.

I don't follow:

If you want to disable ACPI, you can pass acpi=off. This is your
workaround for broken ACPI (and only if you happen to have wrirten your
own DTB, because many/most ACPI systems WILL NOT have a DTB to begin
with).

If you have ACPI, for what technical reason would you not attempt to use
it by default?

There will be systems which _DO NOT_ have any sort of DTB to begin with.
For VMs, both may be provided. By the necessity of a DTB being present
for bootargs, ACPI _MUST_ take precedence. If you don't want it, you
pass acpi=off, or configure your VM software to not pass an ACPI
configuration table.

Why avoid ACPI by default? So that we can later enable it and discover
it's completely broken? Then we need short-sighted hacks to work around
short-sighted decisions.

The best thing to do is to try and use things, be as strict as possible,
stress the implementation, and blow up early and loudly so that said
systems must be fixed.

People are using Linux for bringup; it is the closest thing to a
validation suite. Being lazy and hacking around things for now will only
make things worse in the long run.

We _CANNOT_ place our fingers in our ears and blind ourselves with the
DT banner. ACPI is ugly, sure, but so is DT. Neither is fundamentally
better than the other. The best thing we can do is make it as easy as
possible to highlight bugs in ACPI implementations and barf such that
people are forced to fix their ACPI implementations.

No other OS supports ACPI on 64-bit arm systems. Being strict should
force implementors to try harder.

> > If this is correct, then replacing the firmware-generated dtb with a
> > user-provided on would implicitly remove the ACPI tables from visibility,
> > which is exactly what we want.
> 
> I was of the impression that firmware patches in the ACPI entries into either
> device-tree before launching the kernel. Is that not the case?

1) The ACPI tables will be registered as UEFI configuration tables,
   within platform-specific UEFI code. Nothing outside of UEFI is
   involved.

1a) A loader (e.g. GRUB, the EFI stub) COULD override the loaded tables.
   This is a workaround, and should never be the standard way of doing
   things. It defeats the point, much like appended DTB.

2) The EFI stub will patch UEFI memory map properties into the DTB. The
   firmware is not involved.

3) The kernel will detect whether EFI is present by the presence of the
   memory map, and try to use it if so. The memory map comes from UEFI,
   and memory nodes (and memreserves) are ignored. Only select
   properties under /chosen (e.g. bootargs) will be used.

4) If booted via EFI, the kernel will look for known UEFI configuration
   tables by (G|U)UID, and set up some pointers.

5) The ACPI code will go and look to see if the ACPI table pointers have
   been initialised. If so, the kernel will attempt to use the ACPI
   tables unlesss instructed otherwise. If using ACPI, the DTB will be
   ignored outside of /chosen.

The ACPI tables or pointers to them are not directly patched into the
DTB at any stage. The choice of using ACPI is left with the kernel.

> And what if some bootloader chooses to do it that way in the future?
> It's better to not assume that they get it right.

For the firmware/loader to do so it would have to work around the kernel
version parameter the stub places in the DTB and the kernel verifies. If
it does so, I would argue said firmware is actively malicious.

> > It's possible that I'm misremembering it though, and it should be
> > documented better.
> 
> Yes, definitely needs to be documented to not leave room for random
> interpretation later on.

We should definitely make the documentation as strict as possible on
what's allowed, and have the kernel barf early on if requirements are
not met.

Thanks,
Mark.
