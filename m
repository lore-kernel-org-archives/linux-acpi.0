From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: About 2 ACPICA table patches
Date: Fri, 16 Jan 2015 00:44:38 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026B7CAD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Purdila, Octavian" <octavian.purdila@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Box, David E" <david.e.box@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Octavian

I noticed there are 2 patches you've sent to the community.
But unfortunately I didn't find them in my mailbox.
Let me comment you here.

https://patchwork.kernel.org/patch/5501621/
This patch seem to be correct.
But Rafael should merge it directly via Linux because acpi_unload_table_id() is not in the ACPICA upstream.
We expect the OSPMs to use acpi_unload_parent_table() instead.
I have a divergences reduction series to achieve the transition.
But they are pending for review for almost half a year.
If you have an environment to test.
Could you help to test this again?
I can prepare the patchset for you.

https://patchwork.kernel.org/patch/5501561/
This patch is correct, I've put it in the 201501 ACPICA release materials for review:
https://patchwork.kernel.org/patch/5501621/
The patch can be found at:
https://github.com/zetalog/acpica/commit/281ff873
So if it is merged, you'll see it in the upstream after 201501 ACPICA release cycle.
And hence Linux trees doesn't need to merge this patch directly.

Thanks and best regards
-Lv
