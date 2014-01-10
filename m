From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 0/2] Add option to disable ACPI Memory Hotplug
Date: Fri, 10 Jan 2014 13:46:17 -0500
Message-ID: <1389379579-18614-1-git-send-email-prarit@redhat.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =50@, x86@kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linn Crosetto <linn@hp.com>, Pekka Enberg <penberg@kernel.org>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Tang Chen <tangchen@cn.fujitsu.com>, Wen Congyang <wency@cn.fujitsu.com>, Vivek Goyal <vgoyal@redhat.com>, kosaki.motohiro@gmail.com, dyoung@redhat.com, linux-acpi@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

This patchset adds the ability for the user to disable ACPI Memory Hotplug
by adding "acpi_no_memhotplug" as a kernel paramaeter, and disables
ACPI Memory Hotplug by default when the memmap=exactmap and mem=X parameters
are used.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>=50%)
Cc: x86@kernel.org
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linn Crosetto <linn@hp.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Wen Congyang <wency@cn.fujitsu.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kosaki.motohiro@gmail.com
Cc: dyoung@redhat.com
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-mm@kvack.org

Prarit Bhargava (2):
  acpi memory hotplug, add parameter to disable memory hotplug [v2]
  x86, e820 disable ACPI Memory Hotplug if memory mapping is specified
    by user

 Documentation/kernel-parameters.txt |    3 +++
 arch/x86/kernel/e820.c              |    8 +++++++-
 drivers/acpi/acpi_memhotplug.c      |   17 +++++++++++++++++
 include/linux/memory_hotplug.h      |    3 +++
 4 files changed, 30 insertions(+), 1 deletion(-)

-- 
1.7.9.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
