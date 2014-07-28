From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Mon, 28 Jul 2014 11:12:29 +0100
Message-ID: <20140728101229.GD24078@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
 <5014834.k6eecMddPC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5014834.k6eecMddPC@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, leif.lindholm@arm.com, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linaro-acpi-private@linaro.org" <linaro-acpi-private@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 28, 2014 at 10:07:50AM +0100, Arnd Bergmann wrote:
> On Saturday 26 July 2014 19:34:48 Olof Johansson wrote:
> > On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > > +Relationship with Device Tree
> > > +-----------------------------
> > > +
> > > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
> > > +exclusive with DT support at compile time.
> > > +
> > > +At boot time the kernel will only use one description method depending on
> > > +parameters passed from the bootloader.
> > 
> > Possibly overriden by kernel bootargs. And as debated for quite a
> > while earlier this year, acpi should still default to off -- if a DT
> > and ACPI are both passed in, DT should at this time be given priority.
> 
> I think this would be harder to do with the way that ACPI is passed in
> to the kernel. IIRC, you always have a minimal DT information based on
> the ARM64 boot protocol, but in the case of ACPI, this contains pointers
> to the ACPI tables, which are then used for populating the Linux platform
> devices (unless acpi=disabled is set), while the other contents of the
> DTB may be present but we skip the of_platform_populate state.
> 
> If this is correct, then replacing the firmware-generated dtb with a
> user-provided on would implicitly remove the ACPI tables from visibility,
> which is exactly what we want.

That's not quite true.

There might not be any DTB, or the user might have provided a DTB with
only /chosen/bootargs. Trying to distinguish the many cases of possible
DTB is broken as a concept.

The EFI stub will attempt to get a DTB from somewhere (provided by
filename or as a system table with a magic UUID), and if it can't find
one will generate an empty stub DTB.

Then it will go and perform some EFI memory setup, placing some
properties in the DTB (which might be a stub) describing the EFI memory
map.

Then we boot the kernel proper, which sees the EFI pointers and looks
for an ACPI table. If they are found, ACPI is used. Otherwise we attempt
to use the DTB (which might be a stub).

Unless ACPI is explcitly disabled, ACPI will be used if present.

Thanks,
Mark.
