From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFD][PATCH 7/7] PM / ACPI: Take device PM QoS flags into account
Date: Mon, 12 Nov 2012 14:07:03 -0700
Message-ID: <CAErSpo7kVb1kLbJ0Y4mYLbzEeZM8dSa-YaZE9B2mN5r74ft-Rg@mail.gmail.com>
References: <201209282351.10663.rjw@sisk.pl> <201209282356.52558.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <201209282356.52558.rjw@sisk.pl>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Huang Ying <ying.huang@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Aaron Lu <aaron.lu@intel.com>, Jean Pihet <j-pihet@ti.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mark gross <markgross@thegnar.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 28, 2012 at 3:56 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Make ACPI power management routines and PCI power management
> routines depending on ACPI take device PM QoS flags into account
> when deciding what power state to put the device into.
>
> In particular, after this change acpi_pm_device_sleep_state() will
> not return ACPI_STATE_D3_COLD as the deepest available low-power
> state if PM_QOS_FLAG_NO_POWER_OFF is requested for the device and it
> will not require remote wakeup to work for the device in the returned
> low-power state if there is at least one PM QoS flags request for the
> device, but PM_QOS_FLAG_REMOTE_WAKEUP is not requested for it.
>
> Accordingly, acpi_pci_set_power_state() will refuse to put the
> device into D3cold if PM_QOS_FLAG_NO_POWER_OFF is requested for it.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep.c   |   16 ++++++++++++----
>  drivers/pci/pci-acpi.c |    8 +++++++-

This touches a file in drivers/pci, but I expect it depends on all the
previous patches in the series, so if you haven't merged it already,
Rafael, it seems like it makes sense for you to merge this instead of
me.

Bjorn
