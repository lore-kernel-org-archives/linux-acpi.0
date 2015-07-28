From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / PM: Use target_state to set the device power state
Date: Tue, 28 Jul 2015 17:59:38 +0200
Message-ID: <6917556.GA7pjcvNI8@vostro.rjw.lan>
References: <1438080681-3364-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438080681-3364-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 28, 2015 01:51:21 PM Mika Westerberg wrote:
> Commit 20dacb71ad28 ("ACPI / PM: Rework device power management to follow
> ACPI 6") changed the device power management to use D3hot if the device
> in question does not have _PR3 method even if D3cold was requested by the
> caller.
> 
> However, if the device has _PR3 device->power.state is also set to D3hot
> instead of D3Cold after power resources have been turned off because
> device->power.state will be assigned from "state" instead of
> "target_state".
> 
> Next time the device is transitioned to D0, acpi_power_transition() will
> find that the current power state of the device is D3hot instead of D3cold
> which causes it to power down all resources required for the current
> (wrong) state D3hot.
> 
> Below is a simplified ASL example of a real touch panel device which
> triggers the problem:
> 
>   Scope (TPL1)
>   {
>       Name (_PR0, Package (1) { \_SB.PCI0.I2C1.PXTC })
>       Name (_PR3, Package (1) { \_SB.PCI0.I2C1.PXTC })
>       ...
>   }
> 
> In both D0 and D3hot the same power resource is required. However, when
> acpi_power_transition() turns off power resources required for D3hot (as
> the device is transitioned to D0) it powers down PXTC which then makes the
> device to lose its power.
> 
> Fix this by assigning "target_state" to the device power state instead of
> "state" that is always D3hot even for devices with valid _PR3.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!

Rafael
