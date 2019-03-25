From: Matthew Garrett <matthewgarrett@google.com>
Subject: [PATCH 16/27] acpi: Disable APEI error injection if the kernel is
 locked down
Date: Mon, 25 Mar 2019 15:09:43 -0700
Message-ID: <20190325220954.29054-17-matthewgarrett@google.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jmorris@namei.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, Linn Crosetto <linn@hpe.com>, linux-acpi@vger.kernel.org, Matthew Garrett <matthewgarrett@google.com>
List-Id: linux-acpi@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

ACPI provides an error injection mechanism, EINJ, for debugging and testing
the ACPI Platform Error Interface (APEI) and other RAS features.  If
supported by the firmware, ACPI specification 5.0 and later provide for a
way to specify a physical memory address to which to inject the error.

Injecting errors through EINJ can produce errors which to the platform are
indistinguishable from real hardware errors.  This can have undesirable
side-effects, such as causing the platform to mark hardware as needing
replacement.

While it does not provide a method to load unauthenticated privileged code,
the effect of these errors may persist across reboots and affect trust in
the underlying hardware, so disable error injection through EINJ if
the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/apei/einj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index fcccbfdbdd1a..9fe6bbab2e7d 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -518,6 +518,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	int rc;
 	u64 base_addr, size;
 
+	if (kernel_is_locked_down("ACPI error injection"))
+		return -EPERM;
+
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
 		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
-- 
2.21.0.392.gf8f6787159e-goog
