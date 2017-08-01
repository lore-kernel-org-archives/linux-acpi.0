From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 0/3] Refactor GHES to better support non-APEI systems
Date: Tue,  1 Aug 2017 14:36:05 +0100
Message-ID: <20170801133608.21017-1-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

Hi,

The small series re-factors the GHES driver initialisation to move
memory allocation and checks from driver init to device probe. The net
effect is to improve the situation for systems that do not support
APEI.

The patches are organised as -

* Unify estatus pool creation and expansion into ghes_estatus_pool_init()
* Move memory initialisation and firmware first support checks from
  driver init to device probe
* Do not set hest_disable if HEST not found

The set of patches initially started out as a single patch[0]. The
current series is the re-worked approach based on ensuing
discussion. They patches are based on v4.13-rc3 and have been tested
on a system that does not support APEI. Further testing on systems
that support APEI to ensure that the changes do not break expected
behaviour will be greatly appreciated.

Thanks,
Punit

[0] https://lkml.org/lkml/2017/7/20/430

Punit Agrawal (3):
  GHES: Expand the estatus pool in ghes_estatus_pool_init()
  GHES: Move memory initialisation to ghes_probe()
  ACPI / APEI: HEST: Don't set hest_disable if table not found

 drivers/acpi/apei/ghes.c | 132 ++++++++++++++++++++++++++---------------------
 drivers/acpi/apei/hest.c |   2 +-
 2 files changed, 73 insertions(+), 61 deletions(-)

-- 
2.11.0
