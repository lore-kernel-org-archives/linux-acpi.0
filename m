From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] tools/power/acpi: exclude tools/* from .gitignore pattern
Date: Mon, 29 Apr 2019 23:45:06 +0900
Message-ID: <1556549106-16119-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

tools/power/acpi/.gitignore has the following entries:

  acpidbg
  acpidump
  ec

They are intended to ignore the following build artifacts:

  tools/power/acpi/acpidbg
  tools/power/acpi/acpidump
  tools/power/acpi/ec

However, those .gitignore entries are effective not only for the
current directory, but also for any sub-directories.

So, the following directories are also considered to be ignored:

  tools/power/acpi/tools/acpidbg
  tools/power/acpi/tools/acpidump
  tools/power/acpi/tools/ec

They are obviously version-controlled, so should be excluded from the
.gitignore patterns.

You can fix it by prefixing the patterns with '/', which means they
are only effective in the current directory.

I also prefixed the "include" consistently. IMHO, '/' prefixing is
safer when you intend to ignore specific files or directories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 tools/power/acpi/.gitignore | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
index cba3d99..f698a0e 100644
--- a/tools/power/acpi/.gitignore
+++ b/tools/power/acpi/.gitignore
@@ -1,4 +1,4 @@
-acpidbg
-acpidump
-ec
-include
+/acpidbg
+/acpidump
+/ec
+/include/
-- 
2.7.4
