From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Add hotplug contexts to PCI host bridges
Date: Wed, 11 Jun 2014 20:08:08 +0200
Message-ID: <CAJZ5v0gFVjUwDiCYM_qeU7jL5Ym50mgMZG186G92uMdzMQo8TQ@mail.gmail.com>
References: <1986515.ZPZrccsmiq@vostro.rjw.lan>
	<CAErSpo5rpdb985tS91BOEGJePwU3OSzKp_KgrrZfRqaxKBgPMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo5rpdb985tS91BOEGJePwU3OSzKp_KgrrZfRqaxKBgPMw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 11, 2014 at 4:29 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jun 10, 2014 at 2:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> After relatively recent changes in the ACPI-based PCI hotplug
>> (ACPIPHP) code, the acpiphp_check_host_bridge() executed for PCI
>> host bridges via acpi_pci_root_scan_dependent() doesn't do anything
>> useful, because those bridges do not have hotplug contexts.  That
>> happens by mistake, so fix it by making acpiphp_enumerate_slots()
>> add hotplug contexts to PCI host bridges too and modify
>> acpiphp_remove_slots() to drop those contexts for host bridges
>> as appropriate.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=76901
>> Fixes: 2d8b1d566a5f (ACPI / hotplug / PCI: Get rid of check_sub_bridges())
>> Reported-and-tested-by: Gavin Guo <gavin.guo@canonical.com>
>> Cc: 3.15+ <stable@vger.kernel.org> # 3.15+
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> Rafael, do you want to merge this via your tree, since you merged the
> original acpiphp rework?

Yes, I'll take care of this.

> I do have a small cleanup of acpiphp_glue.c in my queue, but it won't
> conflict with this.
>
> Thanks a lot for fixing this!

You're very welcome. :-)

Rafael
