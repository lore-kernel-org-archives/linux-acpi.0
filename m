From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Tue, 29 Jul 2014 12:41:51 +0200
Message-ID: <3160422.qOzPuCmCVY@wuerfel>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <20140728164459.GD32359@quad.lixom.net> <20140729102940.GB18250@cbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140729102940.GB18250@cbox>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, rob.herring@linaro.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linaro-acpi-private@linaro.org" <linaro-acpi-private@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 29 July 2014 12:29:40 Christoffer Dall wrote:
> On Mon, Jul 28, 2014 at 09:44:59AM -0700, Olof Johansson wrote:
> > On Mon, Jul 28, 2014 at 11:06:54AM +0100, Mark Rutland wrote:
> > 
> > > From the discussions at the last Linaro Connect, this was seen as
> > > important for virtual machines which want to provide ACPI services to
> > > guests while still being able to boot DT-only kernels. I'll leave it to
> > > Grant, Rob, and Christoffer to cover that.
> > 
> > Ok, waiting to see what they have to say then.
> > 
> 
> Hmm, a virtual machine implementaion may provide either a DT or ACPI (or
> both).  I think the point at Linaro Connect was that for a first cut,
> there is no obvious need to provide ACPI to VMs and to be spec
> compliant, server kernels must be able to boot with DT-only.  In most
> cases such systems will only access a few limited emulated devices
> (UART, GIC, RTC, flash controller) and VirtIO devices, which should just
> work using DT only.

Right

> People are talking about adding ACPI for VM guests as well for various
> reasons (device passthrough for example) in which case I would always
> expect people to run UEFI inside their guests too (perhaps this is not
> 100% true in the case of Xen fast-boot scenarios though) and I would
> expect Linux to only see the little stub DT and ACPI.
> 
> Does this clarify anything or add futher to the confusion?

I think the only reason that was given for ACPI in a virtual machine
was Red Hat's insistence on intentionally breaking DT support in their
enterprise distro.

I believe both the cases of device pass-through and running something
other than UEFI are outside of the scope of the standard virtual machine
model, for different reasons. Outside of that model, anybody is of course
free to run whatever they like in their guests.

	Arnd
