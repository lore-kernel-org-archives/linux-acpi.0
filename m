From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/4] PM: Use CONFIG_PM instead of CONFIG_PM_RUNTIME in core code
Date: Mon, 01 Dec 2014 17:01:40 -0800
Message-ID: <7hd28250gb.fsf@deeprootsystems.com>
References: <37310416.jZXoh5nfSC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <37310416.jZXoh5nfSC@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Thu, 27 Nov 2014 01:37:13 +0100")
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <bhelgaas@google.com>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> Hi,
>
> After commit b2b49ccbdd54 "PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected" (currently in Linux next) CONFIG_PM_RUNTIME is set whenever
> CONFIG_PM is set, so CONFIG_PM can be used in #ifdefs instead of
> CONFIG_PM_RUNTIME which simplifies things in quite a few cases.
>
> For this reason, the following patches modify some core code to use
> CONFIG_PM instead of CONFIG_PM_RUNTIME.
>
> [1/4] Drop a macro which is redundant after the above commit.
> [2/4] Use PM instead of PM_RUNTIME in the core device PM code.
> [3/4] Use PM instead of PM_RUNTIME in the ACPI core.
> [4/4] Use PM instead of PM_RUNTIME in the PCI core.
>
> They build for me for all of the relevant combinations of options (on x86),
> but more testing (on the other architectures) would be welcome.

Acked-by: Kevin Hilman <khilman@linaro.org>

I gave this a quick boot test on all the OMAP boards I have, and it's
booting fine. As soon as this hits linux-next, it will be boot tested on
a pile of different ARM platforms, and will let you know what happens.

Kevin
