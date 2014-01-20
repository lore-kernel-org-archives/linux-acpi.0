From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/20] ARM64 / ACPI: Introduce some PCI functions when PCI
 is enabled
Date: Mon, 20 Jan 2014 19:39:52 +0100
Message-ID: <201401201939.53035.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <4387274.ri38HmFxAV@wuerfel> <52DD2F23.2010109@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52DD2F23.2010109@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rob Herring <robh@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, Olof Johansson <olof@lixom.net>, Charles.Garcia-Tobin@arm.com, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 20 January 2014, Hanjun Guo wrote:
> >> acpi_register_ioapic()/acpi_unregister_ioapic() will be used for IOAPIC
> >> hotplug and GIC distributor is something like IOAPIC on x86, so I think
> >> these two functions can be reserved for future use.
> > But GIC is not hotplugged, is it? It still sounds x86 specific to me.
> 
> Well, if we want to do physical CPU hotplug on ARM/ARM64 (maybe years 
> later?),
> then GIC add/remove is needed because we have to remove GIC
> on the SoC too when we remove the physical CPU.

In general, I recommend not planning for the future in kernel code when you
don't know what is going to happen. It's always easy enough to change
things once you get there, as long as no stable ABI is involved.

I just looked at the caller of these functions, and found a self-contained
PCI driver in drivers/pci/ioapic.c, which uses two sepate PCI classes for
ioapic and ioxapic. I think it's a safe assumption to say that even if we
get ARM CPU+GIC hotplug, that would not use the same ioapic driver. This
driver is currently marked X86-only, and that should probably stay this way,
so you won't need the hooks.

	Arnd
