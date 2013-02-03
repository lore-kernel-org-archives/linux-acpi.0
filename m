From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI scan handler for memory hotplug and container simplification
Date: Mon, 04 Feb 2013 00:45:06 +0100
Message-ID: <3164478.OcagzIMET0@vostro.rjw.lan>
References: <1873429.MS5RQDxTye@vostro.rjw.lan> <4311642.nDd2RCVeDc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4311642.nDd2RCVeDc@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi All,

Patch [1/2] in this series makes the ACPI memory hotplug driver use struct
acpi_scan_handler instead of struct acpi_driver and changes the driver to
non-modular (as a consequence).

Patch [2/2] is a bit funny, though.  I though I'd make the container driver
use struct acpi_scan_handler instead of struct acpi_driver too, but then I
noticed that its struct acpi_driver and everything it does is just plain
garbage without any use whatsoever, so the patch simply drops that stuff.

Both on top of linux-pm.git/bleeding-edge.  Unfortunately, I don't have the
hardware to test those things, so if anyone can test them, I'll appreciate it
a lot.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
