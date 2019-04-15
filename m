From: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/2] HMAT memroy hotplug support
Date: Mon, 15 Apr 2019 09:16:52 -0600
Message-ID: <20190415151654.15913-1-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Brice Goglin <Brice.Goglin@inria.fr>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

This is much the same as the original version, accept there's an initial
patch to add hotplug support for memory caching. The first version only
provided the attributes for locality and performance.

The second patch adds the hotplug support via memory notifier. The
difference from v1 is the added lock, ensuring onlining multiple regions
is single threaded to prevent duplicate hmat registration races.

Keith Busch (2):
  hmat: Register memory-side cache after parsing
  hmat: Register attributes for memory hot add

 drivers/acpi/hmat/hmat.c | 108 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 26 deletions(-)

-- 
2.14.4
