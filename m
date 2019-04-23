From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 25/63] Documentation: add Linux PCI to Sphinx TOC tree
Date: Wed, 24 Apr 2019 00:28:54 +0800
Message-ID: <20190423162932.21428-26-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Add a index.rst for PCI subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/index.rst | 9 +++++++++
 Documentation/index.rst     | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/PCI/index.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
new file mode 100644
index 000000000000..c2f8728d11cf
--- /dev/null
+++ b/Documentation/PCI/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Linux PCI Bus Subsystem
+=======================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
diff --git a/Documentation/index.rst b/Documentation/index.rst
index fdfa85c56a50..d80138284e0f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -100,6 +100,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   PCI/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1
