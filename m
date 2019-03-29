From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Date: Fri, 29 Mar 2019 08:11:11 +0800
Message-ID: <20190329001135.15847-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi Corbet and All,
The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted most of the Linux ACPI docs to rst
format in this serias.

For you to preview, please visit below url:
http://104.238.181.70:8080/kernel-doc/acpi/index.html

Thank you!

v2:
  o Update MAINTAINERS.
  o Add SPDX tags for all docs.

Changbin Du (24):
  Documentation: add Linux ACPI to Sphinx TOC tree
  acpi doc: convert acpi/namespace.txt to rst format
  acpi doc: convert acpi/enumeration.txt to rst format
  acpi doc: convert acpi/osi.txt to rst format
  acpi doc: convert acpi/linuxized-acpica.txt to rst format
  acpi doc: convert acpi/scan_handlers.txt to rst format
  acpi doc: convert acpi/DSD-properties-rules.txt to rst format
  acpi doc: convert acpi/gpio-properties.txt to rst format
  acpi doc: convert acpi/method-customizing.txt to rst format
  acpi doc: convert acpi/initrd_table_override.txt to rst format
  acpi doc: convert acpi/dsdt-override.txt to rst format
  acpi doc: convert acpi/i2c-muxes.txt to rst format
  acpi doc: convert acpi/acpi-lid.txt to rst format
  acpi doc: convert acpi/dsd/graph.txt to rst format
  acpi doc: convert acpi/dsd/data-node-references.txt to rst format
  acpi doc: convert acpi/debug.txt to rst format
  acpi doc: convert acpi/method-tracing.txt to rst format
  acpi doc: convert acpi/aml-debugger.txt to rst format
  acpi doc: convert acpi/apei/output_format.txt to rst format
  acpi doc: convert acpi/apei/einj.txt to rst format
  acpi doc: convert acpi/cppc_sysfs.txt to rst format
  acpi doc: convert acpi/lpit.txt to rst format
  acpi doc: convert acpi/ssdt-overlays.txt to rst format
  acpi doc: convert acpi/video_extension.txt to rst format

 ...ies-rules.txt => DSD-properties-rules.rst} |  21 +-
 .../acpi/{acpi-lid.txt => acpi-lid.rst}       |  48 ++-
 Documentation/acpi/aml-debugger.rst           |  75 +++++
 Documentation/acpi/aml-debugger.txt           |  66 ----
 .../acpi/apei/{einj.txt => einj.rst}          |  98 +++---
 Documentation/acpi/apei/output_format.rst     | 150 +++++++++
 Documentation/acpi/apei/output_format.txt     | 147 ---------
 .../acpi/{cppc_sysfs.txt => cppc_sysfs.rst}   |  71 ++--
 Documentation/acpi/{debug.txt => debug.rst}   |  31 +-
 ...eferences.txt => data-node-references.rst} |  28 +-
 .../acpi/dsd/{graph.txt => graph.rst}         | 157 ++++-----
 .../{dsdt-override.txt => dsdt-override.rst}  |   8 +-
 .../acpi/{enumeration.txt => enumeration.rst} | 135 ++++----
 ...pio-properties.txt => gpio-properties.rst} |  78 +++--
 Documentation/acpi/i2c-muxes.rst              |  61 ++++
 Documentation/acpi/i2c-muxes.txt              |  58 ----
 Documentation/acpi/index.rst                  |  32 ++
 Documentation/acpi/initrd_table_override.rst  | 120 +++++++
 Documentation/acpi/initrd_table_override.txt  | 111 -------
 ...uxized-acpica.txt => linuxized-acpica.rst} | 115 ++++---
 Documentation/acpi/{lpit.txt => lpit.rst}     |  18 +-
 Documentation/acpi/method-customizing.rst     |  82 +++++
 Documentation/acpi/method-customizing.txt     |  73 -----
 Documentation/acpi/method-tracing.rst         | 225 +++++++++++++
 Documentation/acpi/method-tracing.txt         | 192 -----------
 .../acpi/{namespace.txt => namespace.rst}     | 310 +++++++++---------
 Documentation/acpi/{osi.txt => osi.rst}       |  15 +-
 .../{scan_handlers.txt => scan_handlers.rst}  |  24 +-
 Documentation/acpi/ssdt-overlays.rst          | 180 ++++++++++
 Documentation/acpi/ssdt-overlays.txt          | 172 ----------
 ...ideo_extension.txt => video_extension.rst} |  63 ++--
 Documentation/index.rst                       |   1 +
 MAINTAINERS                                   |   2 +-
 33 files changed, 1596 insertions(+), 1371 deletions(-)
 rename Documentation/acpi/{DSD-properties-rules.txt => DSD-properties-rules.rst} (88%)
 rename Documentation/acpi/{acpi-lid.txt => acpi-lid.rst} (77%)
 create mode 100644 Documentation/acpi/aml-debugger.rst
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 rename Documentation/acpi/apei/{einj.txt => einj.rst} (67%)
 create mode 100644 Documentation/acpi/apei/output_format.rst
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 rename Documentation/acpi/{cppc_sysfs.txt => cppc_sysfs.rst} (51%)
 rename Documentation/acpi/{debug.txt => debug.rst} (91%)
 rename Documentation/acpi/dsd/{data-node-references.txt => data-node-references.rst} (79%)
 rename Documentation/acpi/dsd/{graph.txt => graph.rst} (56%)
 rename Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} (56%)
 rename Documentation/acpi/{enumeration.txt => enumeration.rst} (87%)
 rename Documentation/acpi/{gpio-properties.txt => gpio-properties.rst} (81%)
 create mode 100644 Documentation/acpi/i2c-muxes.rst
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/acpi/index.rst
 create mode 100644 Documentation/acpi/initrd_table_override.rst
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 rename Documentation/acpi/{linuxized-acpica.txt => linuxized-acpica.rst} (78%)
 rename Documentation/acpi/{lpit.txt => lpit.rst} (68%)
 create mode 100644 Documentation/acpi/method-customizing.rst
 delete mode 100644 Documentation/acpi/method-customizing.txt
 create mode 100644 Documentation/acpi/method-tracing.rst
 delete mode 100644 Documentation/acpi/method-tracing.txt
 rename Documentation/acpi/{namespace.txt => namespace.rst} (54%)
 rename Documentation/acpi/{osi.txt => osi.rst} (97%)
 rename Documentation/acpi/{scan_handlers.txt => scan_handlers.rst} (90%)
 create mode 100644 Documentation/acpi/ssdt-overlays.rst
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt
 rename Documentation/acpi/{video_extension.txt => video_extension.rst} (79%)

-- 
2.20.1
