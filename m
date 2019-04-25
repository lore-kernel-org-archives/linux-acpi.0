From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 00/24] Include linux ACPI docs into Sphinx TOC tree
Date: Thu, 25 Apr 2019 23:30:53 +0800
Message-ID: <20190425153117.16057-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi All,
The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
reST format in this serias.

The hieararchy of ACPI docs are based on Corbet's suggestion:
https://lkml.org/lkml/2019/4/3/1047
I did some adjustment according to the content and finally they are placed as:
Documentation/firmware-guide/acpi/
├── acpi-lid.rst
├── aml-debugger.rst
├── apei
│   ├── einj.rst
│   └── output_format.rst
├── debug.rst
├── dsd
│   ├── data-node-references.rst
│   └── graph.rst
├── DSD-properties-rules.rst
├── enumeration.rst
├── gpio-properties.rst
├── i2c-muxes.rst
├── lpit.rst
├── method-customizing.rst
├── method-tracing.rst
├── namespace.rst
├── osi.rst
└── video_extension.rst
Documentation/driver-api/acpi/
├── linuxized-acpica.rst
└── scan_handlers.rst
ocumentation/admin-guide/acpi/
├── cppc_sysfs.rst
├── dsdt-override.rst
├── initrd_table_override.rst
└── ssdt-overlays.rst

For you to preview, please visit below url:
http://www.bytemem.com:8080/kernel-doc/index.html

Many thanks for all the comments!

v6: add a missed patch.
v5: Fix all comments from Mauro. Thanks for your careful review!

Changbin Du (24):
  Documentation: add Linux ACPI to Sphinx TOC tree
  Documentation: ACPI: move namespace.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move enumeration.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move osi.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move linuxized-acpica.txt to driver-api/acpi and
    convert to  reST
  Documentation: ACPI: move scan_handlers.txt to driver-api/acpi and
    convert to reST
  Documentation: ACPI: move DSD-properties-rules.txt to
    firmware-guide/acpi and covert to reST
  Documentation: ACPI: move gpio-properties.txt to firmware-guide/acpi
    and convert to reST
  Documentation: ACPI: move method-customizing.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move initrd_table_override.txt to
    admin-guide/acpi and convert to reST
  Documentation: ACPI: move dsdt-override.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move i2c-muxes.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move acpi-lid.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move dsd/data-node-references.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move debug.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move method-tracing.txt to firmware-guide/acpi
    and convert to rsST
  Documentation: ACPI: move aml-debugger.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move apei/output_format.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move apei/einj.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move cppc_sysfs.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move lpit.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move ssdt-overlays.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move video_extension.txt to firmware-guide/acpi
    and convert to reST

 Documentation/acpi/aml-debugger.txt           |  66 ----
 Documentation/acpi/apei/output_format.txt     | 147 ---------
 Documentation/acpi/i2c-muxes.txt              |  58 ----
 Documentation/acpi/initrd_table_override.txt  | 111 -------
 Documentation/acpi/method-customizing.txt     |  73 -----
 Documentation/acpi/method-tracing.txt         | 192 ------------
 Documentation/acpi/ssdt-overlays.txt          | 172 ----------
 .../acpi/cppc_sysfs.rst}                      |  71 +++--
 .../acpi/dsdt-override.rst}                   |   8 +-
 Documentation/admin-guide/acpi/index.rst      |  14 +
 .../acpi/initrd_table_override.rst            | 115 +++++++
 .../admin-guide/acpi/ssdt-overlays.rst        | 180 +++++++++++
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/driver-api/acpi/index.rst       |   9 +
 .../acpi/linuxized-acpica.rst}                | 109 ++++---
 .../acpi/scan_handlers.rst}                   |  24 +-
 Documentation/driver-api/index.rst            |   1 +
 .../acpi/DSD-properties-rules.rst}            |  21 +-
 .../acpi/acpi-lid.rst}                        |  40 ++-
 .../firmware-guide/acpi/aml-debugger.rst      |  75 +++++
 .../acpi/apei/einj.rst}                       |  94 +++---
 .../acpi/apei/output_format.rst               | 150 +++++++++
 .../acpi/debug.rst}                           |  31 +-
 .../acpi/dsd/data-node-references.rst}        |  36 ++-
 .../acpi/dsd/graph.rst}                       | 157 +++++-----
 .../acpi/enumeration.rst}                     | 135 ++++----
 .../acpi/gpio-properties.rst}                 |  78 +++--
 .../firmware-guide/acpi/i2c-muxes.rst         |  61 ++++
 Documentation/firmware-guide/acpi/index.rst   |  26 ++
 .../lpit.txt => firmware-guide/acpi/lpit.rst} |  18 +-
 .../acpi/method-customizing.rst               |  89 ++++++
 .../firmware-guide/acpi/method-tracing.rst    | 238 ++++++++++++++
 .../acpi/namespace.rst}                       | 294 +++++++++---------
 .../osi.txt => firmware-guide/acpi/osi.rst}   |  15 +-
 .../acpi/video_extension.rst}                 |  85 +++--
 Documentation/firmware-guide/index.rst        |  13 +
 Documentation/index.rst                       |  10 +
 MAINTAINERS                                   |   2 +-
 38 files changed, 1659 insertions(+), 1360 deletions(-)
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 delete mode 100644 Documentation/acpi/method-customizing.txt
 delete mode 100644 Documentation/acpi/method-tracing.txt
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt
 rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
 rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)
 create mode 100644 Documentation/admin-guide/acpi/index.rst
 create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst
 create mode 100644 Documentation/admin-guide/acpi/ssdt-overlays.rst
 create mode 100644 Documentation/driver-api/acpi/index.rst
 rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (80%)
 rename Documentation/{acpi/scan_handlers.txt => driver-api/acpi/scan_handlers.rst} (90%)
 rename Documentation/{acpi/DSD-properties-rules.txt => firmware-guide/acpi/DSD-properties-rules.rst} (88%)
 rename Documentation/{acpi/acpi-lid.txt => firmware-guide/acpi/acpi-lid.rst} (86%)
 create mode 100644 Documentation/firmware-guide/acpi/aml-debugger.rst
 rename Documentation/{acpi/apei/einj.txt => firmware-guide/acpi/apei/einj.rst} (67%)
 create mode 100644 Documentation/firmware-guide/acpi/apei/output_format.rst
 rename Documentation/{acpi/debug.txt => firmware-guide/acpi/debug.rst} (91%)
 rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (71%)
 rename Documentation/{acpi/dsd/graph.txt => firmware-guide/acpi/dsd/graph.rst} (56%)
 rename Documentation/{acpi/enumeration.txt => firmware-guide/acpi/enumeration.rst} (87%)
 rename Documentation/{acpi/gpio-properties.txt => firmware-guide/acpi/gpio-properties.rst} (81%)
 create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst
 create mode 100644 Documentation/firmware-guide/acpi/index.rst
 rename Documentation/{acpi/lpit.txt => firmware-guide/acpi/lpit.rst} (68%)
 create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
 create mode 100644 Documentation/firmware-guide/acpi/method-tracing.rst
 rename Documentation/{acpi/namespace.txt => firmware-guide/acpi/namespace.rst} (56%)
 rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)
 rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (68%)
 create mode 100644 Documentation/firmware-guide/index.rst

-- 
2.20.1
