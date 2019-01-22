From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI: EC: Simplify boot EC setup
Date: Tue, 22 Jan 2019 12:55:18 +0100
Message-ID: <2897234.rJkq6cDEjt@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Erik Schmauss <erik.schmauss@intel.com>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi All,

The setup of the boot EC is unnecessarily tangled now, so untangle it to
make the code flow in there easier to follow.

The only intentional functional impact of this series should be changes
in messages printed to the kernel log.

The patches are on top of https://patchwork.kernel.org/patch/10773757/

Thanks,
Rafael
