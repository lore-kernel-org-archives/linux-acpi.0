From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2] Documentation / cpu hotplug: Rephrase the outdated description for MADT entries
Date: Fri, 21 Jun 2013 17:09:18 +0800
Message-ID: <1371805758-2841-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Srivatsa Vaddagiri <vatsa@in.ibm.com>, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

More than 256 entries in ACPI MADT is supported from ACPI 3.0, so the
information should be updated.

-v2: Rephrase the information instead of simply removing it according
to Rafael's advice.

Suggested-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 Documentation/cpu-hotplug.txt |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
index 9f40135..67f733d 100644
--- a/Documentation/cpu-hotplug.txt
+++ b/Documentation/cpu-hotplug.txt
@@ -370,8 +370,10 @@ A: There is no clear spec defined way from ACPI that can give us that
    CPUs in MADT as hotpluggable CPUS.  In the case there are no disabled CPUS
    we assume 1/2 the number of CPUs currently present can be hotplugged.
 
-   Caveat: Today's ACPI MADT can only provide 256 entries since the apicid field
-   in MADT is only 8 bits.
+   Caveat: ACPI MADT can only provide 256 entries in systems with only ACPI 2.0c
+   or earlier ACPI version supported, because the apicid field in MADT is only
+   8 bits. From ACPI 3.0, this limitation was removed since the apicid field
+   was extended to 32 bits with x2APIC introduced.
 
 User Space Notification
 
-- 
1.7.9.5
