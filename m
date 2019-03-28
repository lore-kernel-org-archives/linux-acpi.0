From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 11/23] acpi doc: convert acpi/dsdt-override.txt to rst format
Date: Fri, 29 Mar 2019 00:27:09 +0800
Message-ID: <20190328162721.26138-12-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} | 6 +++++-
 Documentation/acpi/index.rst                                | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)
 rename Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} (63%)

diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/acpi/dsdt-override.rst
similarity index 63%
rename from Documentation/acpi/dsdt-override.txt
rename to Documentation/acpi/dsdt-override.rst
index 784841caa6e6..77ecdc44bb2c 100644
--- a/Documentation/acpi/dsdt-override.txt
+++ b/Documentation/acpi/dsdt-override.rst
@@ -1,6 +1,10 @@
+===============
+Overriding DSDT
+===============
+
 Linux supports a method of overriding the BIOS DSDT:
 
-CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
+CONFIG_ACPI_CUSTOM_DSDT - builds the image into the kernel.
 
 When to use this method is described in detail on the
 Linux/ACPI home page:
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 5ab8bad833f6..7701d4df614e 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -14,3 +14,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    scan_handlers
    method-customizing
    initrd_table_override
+   dsdt-override
-- 
2.20.1
