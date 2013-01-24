From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 0/2] Fix section mismatch caused by node offline code.
Date: Thu, 24 Jan 2013 17:38:05 +0800
Message-ID: <1359020287-11661-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, tglx@linutronix.de, minchan.kim@gmail.com, rientjes@google.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, kosaki.motohiro@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com, wency@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com, laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org, glommer@parallels.com, jiang.liu@huawei.com, julian.calaby@gmail.com, sfr@canb.auug.org.au, guz.fnst@cn.fujitsu.com
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Since node offline code uses __apicid_to_node[] and numa_clear_node(),
they are no longer init data or function. So do not declare them as
__cpuinitdata or __cpuinit.

Tang Chen (2):
  cpu_hotplug: Remove __cpuinitdata declaration of __apicid_to_node[].
  cpu-hotplug,memory-hotplug: Remove __cpuinit declaration of
    numa_clear_node().

 arch/x86/mm/numa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
