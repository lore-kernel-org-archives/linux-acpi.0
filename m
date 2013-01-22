From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH Bug fix 0/5] Bug fix for node offline
Date: Tue, 22 Jan 2013 19:45:51 +0800
Message-ID: <1358855156-6126-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, tglx@linutronix.de, minchan.kim@gmail.com, rientjes@google.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, kosaki.motohiro@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com, wency@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com, laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org, glommer@parallels.com, jiang.liu@huawei.com, julian.calaby@gmail.com, sfr@canb.auug.org.au
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Based on physical memory hot-remove functionality, we can implement
node hot-remove. But there are some problems in cpu driver when offlining
a node. This patch-set will fix them.

All these patches are based on the latest -mm tree.
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm

Tang Chen (1):
  Do not use cpu_to_node() to find an offlined cpu's node.

Wen Congyang (4):
  cpu_hotplug: clear apicid to node when the cpu is hotremoved
  memory-hotplug: export the function try_offline_node()
  cpu-hotplug, memory-hotplug: try offline the node when hotremoving a
    cpu
  cpu-hotplug,memory-hotplug: clear cpu_to_node() when offlining the
    node

 arch/x86/kernel/acpi/boot.c     |    4 ++++
 drivers/acpi/processor_driver.c |    2 ++
 include/linux/memory_hotplug.h  |    2 ++
 kernel/sched/core.c             |   28 +++++++++++++++++++---------
 mm/memory_hotplug.c             |   33 +++++++++++++++++++++++++++++++--
 5 files changed, 58 insertions(+), 11 deletions(-)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
