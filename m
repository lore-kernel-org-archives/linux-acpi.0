From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI, ACPI: hold acpi_scan_lock during root bus hotplug
Date: Tue, 26 Mar 2013 23:54:12 +0100
Message-ID: <2166148.RX0m5V0khX@vostro.rjw.lan>
References: <1673357.1IdxNNvGWX@vostro.rjw.lan> <34989330.IyIZ6Qqfxh@vostro.rjw.lan> <CAE9FiQVSZd216JrdHdeLSrr1k0d5xTCmLz9FH151BHDDo8KRAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQVSZd216JrdHdeLSrr1k0d5xTCmLz9FH151BHDDo8KRAQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 26, 2013 08:12:30 AM Yinghai Lu wrote:
> On Tue, Mar 26, 2013 at 6:24 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday, March 10, 2013 10:05:16 PM Yinghai Lu wrote:
> >> During merging pci tree with pm/acpi tree, Linus noticed that
> >> we don't have same lock using patten about acpi pci root as
> >> acpiphp.
> >>
> >> Here apply same lock patten, and we need to change
> >> acpi_bus_hot_remove_device executing via acpi_os_hotplug_execute()
> >> as it also hold the lock in acpi_bus_hot_remove_device.
> >>
> >> That will make acpi_bus_hot_remove_device calling the same as other
> >> callers.
> >>
> >> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Bjorn, this needs to go in before final 3.9.
> >
> > Are you going to handle it, or should I take care of it?
> 
> It should be better via your pm+acpi tree, as that lock is added via your tree.

OK, I'll take it, then, if Bjorn doesn't object.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
