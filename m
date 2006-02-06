From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [RFC:PATCH(000/003)] Memory add to onlined node.
Date: Mon, 06 Feb 2006 22:37:08 +0900
Message-ID: <20060206221815.0605.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>, "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>, naveen.b.s@intel.com
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org, x86-64 Discuss <discuss@x86-64.org>
List-Id: linux-acpi@vger.kernel.org

Hello.

I would like to post patches for memory hot-add.
Current code allow addition to just node 0.
By this patch, the new memory is able to be added to appropriate node,
- if the node is already online.-  If the node is offline, 
(It means new node is comming!)  then the memory will belongs
to node 0 yet.

If new memory belongs to new node, new pgdat must be initialized.
But, it still need more many steps. So, I would like to propose
this small steps for a while.

This patch is use acpi's DSDT to fined node id from physicall address.
So, this patch is just for intel/AMD architecture.

I tested this patch on ia64, and confirm copile completion for x86_64.
If there is no objection, I would like to test it too.

This patch is for 2.6.16-rc1-mm5. -mm5 already has pxm_to_nid map's
clean up and add_memory for x86_64. 
So, these patches could be small. :-)

Please comment.

-- 
Yasunori Goto 


