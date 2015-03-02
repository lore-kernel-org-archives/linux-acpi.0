From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [Question] cpu<->node relationship changed with node online/offline
Date: Mon, 2 Mar 2015 09:43:30 +0800
Message-ID: <54F3C042.8090607@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:3847 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752221AbbCBCAt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Mar 2015 21:00:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-numa@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <laijs@cn.fujitsu.com>

Hi numa guys,

Yasuaki Ishimatsu found a phenomenon that the numa mapping (cpu<->node relationship)
changed when hot add/remove node. 
And this change will cause allocation failure bug to workqueue sub-system:
...
  SLUB: Unable to allocate memory on node 2 (gfp=0x80d0)
  cache: kmalloc-192, object size: 192, buffer size: 192, default order: 1, min order: 0
  node 0: slabs: 6172, objs: 259224, free: 245741
  node 1: slabs: 3261, objs: 136962, free: 127656
...

It happened in the following situation:

1) System Node/CPU before offline/online:
	       | CPU
	------------------------
	node 0 |  0-14, 60-74
	node 1 | 15-29, 75-89
	node 2 | 30-44, 90-104
	node 3 | 45-59, 105-119

2) A system-board (contains node2 and node3) is offline:
	       | CPU
	------------------------
	node 0 |  0-14, 60-74
	node 1 | 15-29, 75-89

3) A new system-board (also contains two nodes) is online, two new node
   IDs are allocated for the two node of the SB, but the old CPU IDs
   are allocated for the SB, here the NUMA mapping between node and CPU
   is changed.
   (the node of CPU#30 is changed from node#2 to node#4, for example)
	       | CPU
	------------------------
	node 0 |  0-14, 60-74
	node 1 | 15-29, 75-89
	node 4 | 30-59
	node 5 | 90-119

4) now, the NUMA mapping is changed.

So the question is *why the NUMA mapping needs to be changed?*
We can reuse the free CPU IDs for new cpus, why not reuse the free
node IDs and keep the mapping the same as before?

Looking forward to your response, thanks.

Best regards,
Gu
