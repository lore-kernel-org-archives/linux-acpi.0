From: Brandon Anderson <brandon.anderson@amd.com>
Subject: [PATCH 0/4] ACPI/ARM: AMBA bus ACPI module
Date: Mon, 11 Nov 2013 11:16:06 -0600
Message-ID: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:57198 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754516Ab3KKRRF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Nov 2013 12:17:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ssg.sos.patches@amd.com, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: Brandon Anderson <brandon.anderson@amd.com>

This patch series requires the fixed-clock patches from Hanjun Guo.

Provides an ACPI module to probe ARM AMBA devices that have a
hardware ID, which is used with struct amba_device to match up
the appropriate driver.

See required DSDT definition format below.


Brandon Anderson (4):
  early fixed-clock
  AMBA bus ACPI implementation
  Add ACPI to AMBA SPI driver
  remove unneeded sections of DTS definition

 arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +-
 arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 +
 arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    8 +
 drivers/acpi/acpi_platform.c                      |    2 +
 drivers/amba/Makefile                             |    2 +-
 drivers/amba/acpi.c                               |  339 +++++++++++++++++++++
 drivers/clk/clk-fixed-rate.c                      |    2 +-
 drivers/spi/spi-pl022.c                           |   49 +++
 include/linux/amba/acpi.h                         |   29 ++
 9 files changed, 440 insertions(+), 5 deletions(-)
 create mode 100644 drivers/amba/acpi.c
 create mode 100644 include/linux/amba/acpi.h

-- 
1.7.9.5

-----------

diff --git a/platforms/rtsm_ve-aemv8a.acpi/dsdt.asl b/platforms/rtsm_ve-aemv8a.acpi/dsdt.asl
index 0bcc94d..64e84a4 100644
--- a/platforms/rtsm_ve-aemv8a.acpi/dsdt.asl
+++ b/platforms/rtsm_ve-aemv8a.acpi/dsdt.asl
@@ -252,6 +252,33 @@ DefinitionBlock (
 			}
 		}
 
+		Device (CLK0) {
+			Name (_HID, "LINA0008")
+			Name (_UID, 0)
+
+			Method (FREQ, 0x0, NotSerialized) {
+				Return (24000000)
+			}
+		}
+
+		Device (CLK1) {
+			Name (_HID, "LINA0008")
+			Name (_UID, 1)
+
+			Method (FREQ, 0x0, NotSerialized) {
+				Return (1000000)
+			}
+		}
+
+		Device (CLK2) {
+			Name (_HID, "LINA0008")
+			Name (_UID, 2)
+
+			Method (FREQ, 0x0, NotSerialized) {
+				Return (32768)
+			}
+		}
+
 		Device (PMU0) {
 			Name (_HID, "LINA0007")
 			Name (_UID, 0)
@@ -263,5 +290,229 @@ DefinitionBlock (
 				Return (RBUF)
 			}
 		}
+
+		Method (DTGP, 5, NotSerialized)
+		{
+			If (LEqual (Arg0, Buffer (0x10)
+					{
+					/* UUID:	a706b112-bf0b-48d2-9fa3-95591a3c4c06 */
+					  /* 0000 */	0xa7, 0x06, 0xb1, 0x12, 0xbf, 0x0b, 0x48, 0xd2,
+					  /* 0008 */	0x9f, 0xa3, 0x95, 0x59, 0x1a, 0x3c, 0x4c, 0x06
+					}))
+			{
+				If (LEqual (Arg1, 0x01))
+				{
+					If (LEqual (Arg2, 0x00))
+					{
+						Store (Buffer (0x01)
+						{
+							0x03
+						}, Arg4)
+						Return (0x01)
+					}
+
+					If (LEqual (Arg2, 0x01))
+					{
+						Return (0x01)
+					}
+				}
+			}
+
+			Store (Buffer (0x01)
+			{
+				0x00
+			}, Arg4)
+			Return (0x00)
+		}
+
+		Device (AMBA) {
+			Name (_HID, "AMBA0000") /* the parallel to "arm,primecell" in DTS */
+			Name (_UID, 0)
+
+			/* Define 'apb_pclk' as a default clock source since it is
+			   common with devices below */
+			Method(_DSM, 4, NotSerialized) {
+				Store (Package (2)
+				{
+					"clock-name", "apb_pclk \\_SB.CLK0",
+				}, Local0)
+
+				DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
+
+				Return (Local0)
+			}
+
+			Device (SCT0) {
+				Name (_ADR, 0x1c020000)						/* SYSCTL */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c020000, 0x00001000)
+					})
+					Return (RBUF)
+				}
+				Method(_DSM, 4, Serialized) {
+					Store (Package (4)
+					{
+						"clock-name", "refclk \\_SB.CLK2",
+						"clock-name", "timclk \\_SB.CLK1",
+					}, Local0)
+
+					DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
+
+					Return (Local0)
+				}
+			}
+
+			Device (KMI0) {
+				Name (_ADR, 0x1c060000)
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c060000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {44}
+					})
+					Return (RBUF)
+				}
+				Method(_DSM, 4, Serialized) {
+					Store (Package (2)
+					{
+						"clock-name", "KMIREFCLK \\_SB.CLK0",
+					}, Local0)
+
+					DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
+
+					Return (Local0)
+				}
+			}
+
+			Device (KMI1) {
+				Name (_ADR, 0x1c070000)
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c070000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {45}
+					})
+					Return (RBUF)
+				}
+				Method(_DSM, 4, NotSerialized) {
+					Store (Package (2)
+					{
+						"clock-name", "KMIREFCLK \\_SB.CLK0",
+					}, Local0)
+
+					DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
+
+					Return (Local0)
+				}
+			}
+
+			Device (SER0) {
+				Name (_ADR, 0x1c090000)                         /* UART0 */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c090000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {37}
+					})
+					Return (RBUF)
+				}
+			}
+
+			Device (SER1) {
+				Name (_ADR, 0x1c0a0000)                         /* UART1 */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c0a0000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {38}
+					})
+					Return (RBUF)
+				}
+			}
+			Device (SER2) {
+				Name (_ADR, 0x1c0b0000)                         /* UART2 */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c0b0000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {39}
+					})
+					Return (RBUF)
+				}
+			}
+
+			Device (SER3) {
+				Name (_ADR, 0x1c0c0000)                         /* UART3 */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c0c0000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {40}
+					})
+					Return (RBUF)
+				}
+			}
+
+			Device (AAC0) {
+				Name (_ADR, 0x1c040000)						/* AACI */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c040000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {43}
+					})
+					Return (RBUF)
+				}
+			}
+
+			Device (WDT0) {
+				Name (_ADR, 0x1c0f0000)						/* WDT */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c0f0000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {32}
+					})
+					Return (RBUF)
+				}
+			}
+
+			Device (TIM0) {
+				Name (_ADR, 0x1c110000)						/* TIMER01 */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c110000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {34}
+					})
+					Return (RBUF)
+				}
+			}
+
+			Device (TIM2) {
+				Name (_ADR, 0x1c120000)						/* TIMER23 */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c120000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {35}
+					})
+					Return (RBUF)
+				}
+			}
+
+			Device (RTC0) {
+				Name (_ADR, 0x1c170000)						/* RTC */
+				Method (_CRS, 0x0, Serialized) {
+					Name (RBUF, ResourceTemplate () {
+						Memory32Fixed (ReadWrite, 0x1c170000, 0x00001000)
+						Interrupt (ResourceConsumer, Edge, ActiveBoth,
+								Exclusive, , , ) {36}
+					})
+					Return (RBUF)
+				}
+			}
+		}
 	}
 }

