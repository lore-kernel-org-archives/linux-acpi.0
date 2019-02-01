From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 0/5] ACPI: EC: Simplify boot EC setup
Date: Fri, 01 Feb 2019 10:56:04 +0100
Message-ID: <2804781.zocuRj5ZkX@aspire.rjw.lan>
References: <2897234.rJkq6cDEjt@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2897234.rJkq6cDEjt@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Erik Schmauss <erik.schmauss@intel.com>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi All,

On Tuesday, January 22, 2019 12:55:18 PM CET Rafael J. Wysocki wrote:
> Hi All,
> 
> The setup of the boot EC is unnecessarily tangled now, so untangle it to
> make the code flow in there easier to follow.
> 
> The only intentional functional impact of this series should be changes
> in messages printed to the kernel log.
> 
> The patches are on top of https://patchwork.kernel.org/patch/10773757/

This v2 is here, because the first patch in the previous version contained
too bugs that were overlooked, because it attempted to do too much in one
go.  So this time use smaller patches and add one to make boot_ec static
(which it should be).

Thanks,
Rafael
