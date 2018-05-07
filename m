From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v2 0/2] Add support for general system clock on ST AMD platform
Date: Mon,  7 May 2018 18:13:31 +0800
Message-ID: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com, mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com, airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

AMD ST/CZ platform provides a general system clock which can be used
by any driver. Registration of this clock will done in clk-st driver.
While the ACPI misc device will create the required MMIO mappings
and pass the same to the clk-st driver. The clk-st driver will
use the address to enable/disable and set frequency.

Changelog:
v2:
  clk: x86: Add ST oscout platform clock: v3->v4 unregister clk_hw
  ACPI: APD: Add AMD misc clock handler support: No change (v2)

Akshu Agrawal (2):
  clk: x86: Add ST oscout platform clock
  ACPI: APD: Add AMD misc clock handler support

 drivers/acpi/acpi_apd.c              | 50 ++++++++++++++++++++
 drivers/clk/x86/Makefile             |  1 +
 drivers/clk/x86/clk-st.c             | 88 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 35 ++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/x86/clk-st.c
 create mode 100644 include/linux/platform_data/clk-st.h

-- 
1.9.1
