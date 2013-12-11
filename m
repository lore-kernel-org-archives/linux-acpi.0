From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
Date: Wed, 11 Dec 2013 04:07:27 +0100
Message-ID: <201312110407.27848.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312102100.20570.arnd@arndb.de> <20131210202323.GJ11468@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131210202323.GJ11468@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "patches@linaro.org" <patches@linaro.org>, Olof Johansson <olof@lixom.net>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, rob.herring@calxeda.com
List-Id: linux-acpi@vger.kernel.org

On Tuesday 10 December 2013, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 09:00:20PM +0100, Arnd Bergmann wrote:
> > On Tuesday 10 December 2013, Mark Brown wrote:
> 
> > > It's not just the SoC, it's also the rest of the board.  The patches the
> > > Intel guys are submitting at the minute are mainly for the off-SoC
> > > devices at least as far as I noticed.  This'll impact anyone who ends up
> > > using ACPI, we need to at least pay attention to what's going on there.
> 
> > Yes, but I'm not that worried about off-soc stuff, which tends to be
> > off the much simpler variety: a few MMIO or PIO registers, IRQs,
> > GPIOs or (with ACPI-5.0) devices on i2c and spi buses.
> 
> That's not my experience especially once you get into phone type
> hardware - there's not much complexity difference when gluing things
> into the system and the fact that it's connected by the board increases
> the amount of flexibility that has to be coped with.

Yes, that is probably right. The only argument that one can make about
the mobile phone case is that these devices are so complex that nobody
even bothers any more running upstream kernels on them on any CPU
architecture. If the kernel code is kept out of the mainline tree,
it doesn't matter to us what they use, and the developers don't gain
much by following any of the available firmware models either.

	Arnd
