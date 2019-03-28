From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
Date: Fri, 29 Mar 2019 00:26:58 +0800
Message-ID: <20190328162721.26138-1-changbin.du@gmail.com>
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

Changbin Du (23):
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
  acpi doc: convert acpi/debug.txt to rst format
  acpi doc: convert acpi/method-tracing.txt to rst format
  acpi doc: convert acpi/aml-debugger.txt to rst format
  acpi doc: convert acpi/apei/output_format.txt to rst format
  acpi doc: convert acpi/apei/einj.txt to rst format
  acpi doc: convert acpi/cppc_sysfs.txt to rst format
  acpi doc: convert acpi/lpit.txt to rst format
  acpi doc: convert acpi/ssdt-overlays.txt to rst format
  acpi doc: convert acpi/video_extension.txt to rst format

 ...ies-rules.txt => DSD-properties-rules.rst} |  19 +-
 .../acpi/{acpi-lid.txt => acpi-lid.rst}       |  47 ++-
 Documentation/acpi/aml-debugger.rst           |  74 +++++
 Documentation/acpi/aml-debugger.txt           |  66 ----
 .../acpi/apei/{einj.txt => einj.rst}          |  96 +++---
 Documentation/acpi/apei/output_format.rst     | 148 +++++++++
 Documentation/acpi/apei/output_format.txt     | 147 ---------
 .../acpi/{cppc_sysfs.txt => cppc_sysfs.rst}   |  69 ++--
 Documentation/acpi/{debug.txt => debug.rst}   |  31 +-
 ...eferences.txt => data-node-references.rst} |  27 +-
 .../acpi/dsd/{graph.txt => graph.rst}         | 155 ++++-----
 .../{dsdt-override.txt => dsdt-override.rst}  |   6 +-
 .../acpi/{enumeration.txt => enumeration.rst} | 133 ++++----
 ...pio-properties.txt => gpio-properties.rst} |  76 +++--
 Documentation/acpi/i2c-muxes.rst              |  59 ++++
 Documentation/acpi/i2c-muxes.txt              |  58 ----
 Documentation/acpi/index.rst                  |  30 ++
 Documentation/acpi/initrd_table_override.rst  | 118 +++++++
 Documentation/acpi/initrd_table_override.txt  | 111 -------
 ...uxized-acpica.txt => linuxized-acpica.rst} | 114 ++++---
 Documentation/acpi/{lpit.txt => lpit.rst}     |  16 +-
 Documentation/acpi/method-customizing.rst     |  80 +++++
 Documentation/acpi/method-customizing.txt     |  73 -----
 Documentation/acpi/method-tracing.rst         | 224 +++++++++++++
 Documentation/acpi/method-tracing.txt         | 192 -----------
 .../acpi/{namespace.txt => namespace.rst}     | 309 +++++++++---------
 Documentation/acpi/{osi.txt => osi.rst}       |  13 +-
 .../{scan_handlers.txt => scan_handlers.rst}  |  23 +-
 .../{ssdt-overlays.txt => ssdt-overlays.rst}  | 166 +++++-----
 ...ideo_extension.txt => video_extension.rst} |  61 ++--
 Documentation/index.rst                       |   1 +
 31 files changed, 1463 insertions(+), 1279 deletions(-)
 rename Documentation/acpi/{DSD-properties-rules.txt => DSD-properties-rules.rst} (89%)
 rename Documentation/acpi/{acpi-lid.txt => acpi-lid.rst} (78%)
 create mode 100644 Documentation/acpi/aml-debugger.rst
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 rename Documentation/acpi/apei/{einj.txt => einj.rst} (68%)
 create mode 100644 Documentation/acpi/apei/output_format.rst
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 rename Documentation/acpi/{cppc_sysfs.txt => cppc_sysfs.rst} (51%)
 rename Documentation/acpi/{debug.txt => debug.rst} (91%)
 rename Documentation/acpi/dsd/{data-node-references.txt => data-node-references.rst} (80%)
 rename Documentation/acpi/dsd/{graph.txt => graph.rst} (56%)
 rename Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} (63%)
 rename Documentation/acpi/{enumeration.txt => enumeration.rst} (87%)
 rename Documentation/acpi/{gpio-properties.txt => gpio-properties.rst} (82%)
 create mode 100644 Documentation/acpi/i2c-muxes.rst
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/acpi/index.rst
 create mode 100644 Documentation/acpi/initrd_table_override.rst
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 rename Documentation/acpi/{linuxized-acpica.txt => linuxized-acpica.rst} (78%)
 rename Documentation/acpi/{lpit.txt => lpit.rst} (70%)
 create mode 100644 Documentation/acpi/method-customizing.rst
 delete mode 100644 Documentation/acpi/method-customizing.txt
 create mode 100644 Documentation/acpi/method-tracing.rst
 delete mode 100644 Documentation/acpi/method-tracing.txt
 rename Documentation/acpi/{namespace.txt => namespace.rst} (54%)
 rename Documentation/acpi/{osi.txt => osi.rst} (97%)
 rename Documentation/acpi/{scan_handlers.txt => scan_handlers.rst} (91%)
 rename Documentation/acpi/{ssdt-overlays.txt => ssdt-overlays.rst} (50%)
 rename Documentation/acpi/{video_extension.txt => video_extension.rst} (80%)

-- 
2.20.1
