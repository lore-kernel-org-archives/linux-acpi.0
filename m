From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Mon, 26 Sep 2016 14:23:01 +0200
Message-ID: <2652205.dsh4NuQbCm@vostro.rjw.lan>
References: <201609251512.05657.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201609251512.05657.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, September 25, 2016 03:12:05 PM Ondrej Zary wrote:
> Hello,
> I've upgraded kernel (Debian Squeeze - backports) from 4.6 (4.6.4-1~bpo8+1)
> to 4.7 (4.7.2-1~bpo8+1) and IRQs stopped working with error messages like this:
> 
> ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
> 
> The same thing appeared on two different machines. Is it a known/fixed bug?

Well, maybe.

Can you try 4.8-rc8, please?

Thanks,
Rafael
