From: Michal Hocko <mhocko@kernel.org>
Subject: fd3e45436660 ("ACPI / NUMA: ia64: Parse all entries of SRAT memory
 affinity table")
Date: Wed, 11 Apr 2018 12:48:32 +0200
Message-ID: <20180411104832.GF23400@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, tiantao6@huawei.com, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,
my attention was brought to the %subj commit and either I am missing
something or the patch is quite dubious. What is it actually trying to
fix? If a BIOS/FW provides more memblocks than the limit then we would
get misleading numa topology (numactl -H output) but is the situation
much better with it applied? Numa init code will refuse to init more
memblocks than the limit and falls back to dummy_numa_init (AFAICS)
which will break the topology again and numactl -H will have a
misleading output anyway.

So why is the patch an improvement at all?
-- 
Michal Hocko
SUSE Labs
