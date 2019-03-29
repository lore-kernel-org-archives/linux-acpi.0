From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 01/24] Documentation: add Linux ACPI to Sphinx TOC tree
Date: Fri, 29 Mar 2019 08:11:12 +0800
Message-ID: <20190329001135.15847-2-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Add a index.rst for trace subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/index.rst | 8 ++++++++
 Documentation/index.rst      | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 Documentation/acpi/index.rst

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
new file mode 100644
index 000000000000..7241ceb1673c
--- /dev/null
+++ b/Documentation/acpi/index.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================================
+Linux ACPI (Advanced Configuration and Power Interface) 
+=======================================================
+
+.. toctree::
+   :maxdepth: 2
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..e3aa28275894 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -90,6 +90,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   acpi/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1
