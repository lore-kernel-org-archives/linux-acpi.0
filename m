From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] ACPI: acpi_bind_one()/acpi_unbind_one() cleanups
Date: Tue, 06 Aug 2013 02:22:53 +0200
Message-ID: <3015032.qfOqgEVZKP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

Hi All,

The following 5 patches clean up a little mess in acpi_bind_one() and
acpi_unbind_one().  They are on top of current linux-next plus the patch
at https://patchwork.kernel.org/patch/2839101/ .

[1/5] Move duplicated code from acpi_bind_one()/acpi_unbind_one() to a separate
      function.
[2/5] Create symlinks in acpi_bind_one() under physical_node_lock.
[3/5] Clean up inconsistent use of whitespace in acpi_bind_one()/acpi_unbind_one().
[4/5] Use list_for_each_entry() to walk the list in acpi_unbind_one().
[5/5] Clean up the error code path in acpi_unbind_one().

Thanks,
Rafael
