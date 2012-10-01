From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [RFD][PATCH 0/7] PM / QoS: Support for PM QoS device flags
Date: Mon, 1 Oct 2012 18:17:10 +0200
Message-ID: <CAN5iSWq2UE4gk3VJFdnV_mOxDShrZEKPcBErvNBPVR4iFgmutQ@mail.gmail.com>
References: <201209282351.10663.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201209282351.10663.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Huang Ying <ying.huang@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Aaron Lu <aaron.lu@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mark gross <markgross@thegnar.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On Fri, Sep 28, 2012 at 11:51 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi All,
>
> The following patch series extends the existing device PM QoS core code to
> support PM QoS flags representing binary (on/off) requirements, such as
> whether or not power may be removed entirely from the device or whether
> or not remote wakeup (i.e. signalling of external events while suspended)
> should work for it.
>
> [1/7] Prepare PM QoS device structure for adding more constraint types.
> [2/7] Introduce request and constraint data types for PM QoS flags.
> [3/7] Prepare struct dev_pm_qos_request for representing more request types.
> [4/7] Introduce device PM QoS flags support.
> [5/7] Make it possible to expose PM QoS device flags to user space.
> [6/7] PM / Domains: Check device PM QoS flags in pm_genpd_poweroff().
> [7/7] PM / ACPI: Take device PM QoS flags into account.
>
> The last two patches make the generic PM domains framework and ACPI / PCI,
> respectively, take the PM QoS device flags introduced by patch [5/7] into
> accont when making their decisions.
>
> The changelogs describe the details, but if anything isn't clear, please let
> me know.
That looks OK after review. FWIW:
Reviewed-by: Jean Pihet <j-pihet@ti.com>

Thanks!
Jean

>
> Thanks,
> Rafael
>
