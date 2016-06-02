From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression with commit c3bc26d4b4e3
Date: Thu, 2 Jun 2016 14:22:24 +0200
Message-ID: <CAJZ5v0g6EpVXk3C0bk6BJ-vD1rww0c7ayVARSQC9nFRpL01NXQ@mail.gmail.com>
References: <20160602110805.GB32574@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38161 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbcFBMW0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jun 2016 08:22:26 -0400
Received: by mail-wm0-f53.google.com with SMTP id a20so65054594wma.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jun 2016 05:22:25 -0700 (PDT)
In-Reply-To: <20160602110805.GB32574@quack2.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Lv Zheng <lv.zheng@intel.com>, "devel@acpica.org" <devel@acpica.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thu, Jun 2, 2016 at 1:08 PM, Jan Kara <jack@suse.cz> wrote:
> Hello,
>
> commit c3bc26d4b4e3 (ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset
> support in acpi_hw_read()) broke booting of my KVM test guest. When I
> revert that commit and commit 66b1ed5aa8d (ACPICA: ACPI 2.0, Hardware: Add
> access_width/bit_offset support for acpi_hw_write()) which looks similar,
> the vm boots again. The problem manifests itself that the qemu-kvm just
> aborts after the kernel prints:
>
> [    0.333707] ACPI: bus type PCI registered
> [    0.335494] PCI: Using configuration type 1 for base access
> [    0.472716] ACPI: Added _OSI(Module Device)
> [    0.475360] ACPI: Added _OSI(Processor Device)
> [    0.476012] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.480035] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.494742] ACPI: 2 ACPI AML tables successfully acquired and loaded
> [    0.496003]
>
> For working kernel the messages continue like:
>
> [    0.507616] ACPI: Interpreter enabled
> [    0.508018] ACPI: (supports S0 S5)
> [    0.509129] ACPI: Using IOAPIC for interrupt routing
> [    0.510717] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.533308] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.535049] acpi PNP0A03:00: _OSC: OS supports [Segments]
> [    0.536111] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    0.538702] PCI host bridge to bus 0000:00

We have a fix in this area,
https://patchwork.kernel.org/patch/9145955/, does it help?
