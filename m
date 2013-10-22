From: <brandon.anderson@amd.com>
Subject: =?UTF-8?q?=5BRFC=20PATCH=200/3=5D=20ACPI=3A=20ARM=20AMBA=20bus=20connector=20resource?=
Date: Mon, 21 Oct 2013 19:33:46 -0500
Message-ID: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:35275
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128Ab3JVAef convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Oct 2013 20:34:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@sisk.pl, naresh.bhat@linaro.org, hanjun.guo@linaro.org, graeme.gregory@linaro.org, Suravee.Suthikulpanit@amd.com, Brandon Anderson <brandon.anderson@amd.com>

=46rom: Brandon Anderson <brandon.anderson@amd.com>

This is a proposal for ACPI driver probing of the ARM AMBA devices curr=
ently listed under =E2=80=98iofpga=E2=80=99 in the RTSM dts file. The m=
ain addition is drivers/amba/acpi.c which fits the role of an AMBA bus =
=E2=80=98connector resource=E2=80=99 for ACPI using struct amba_device.

I have not yet figured out the implementation details regarding clocks =
(handled in the dts file with clock-names). However, I have included a =
proposed ASL format for clock information in the DSDT example below. Wi=
th the last patch that hacks the clock info, this prototype will run on=
 the Foundation and RTSM models.

These patches require Hanjun=E2=80=99s fixed-clock patches to be applie=
d first on top of a Linaro ACPI kernel: https://git.linaro.org/gitweb?p=
=3Darm/acpi/leg-kernel.git;a=3Dsummary

Please comment on both the concept and the implementation.

Brandon Anderson (3):
  Remove UART and KMI entries from DTS file
  Prototype of AMBA bus 'connector resource' for ACPI
  Hack clock names to get prototype running

 arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +-
 arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 +
 arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    4 +
 drivers/acpi/acpi_platform.c                      |    2 +
 drivers/amba/Makefile                             |    2 +-
 drivers/amba/acpi.c                               |  172 +++++++++++++=
++++++++
 drivers/clk/clk-fixed-rate.c                      |   15 +-
 7 files changed, 203 insertions(+), 6 deletions(-)
 create mode 100644 drivers/amba/acpi.c

--=20
1.7.9.5


---

		Device (AMBA) {
			Name (_HID, "AMBA0000") /* the parallel to "arm,primecell" in DTS */
			Name (_UID, 0)

			/* Define 'apb_pclk' as a default clock source since it is
			   common with devices below */
			Method(_DSM, 4, NotSerialized) {
				Store (Package (3)
				{
					"clock-name", "apb_pclk", "\\_SB_.CLK0",
				}, Local0)

				Return (Local0)
			}

			Device (KMI0) {
				Name (_ADR,0x1c060000)
				Method (_CRS, 0x0, Serialized) {
					Name (RBUF, ResourceTemplate () {
						Memory32Fixed (ReadWrite, 0x1c060000, 0x00010000)
						Interrupt (ResourceConsumer, Edge, ActiveBoth,
								Exclusive, , , ) {44}
					})
					Return (RBUF)
				}
			}

			Device (KMI1) {
				Name (_ADR,0x1c070000)
				Method (_CRS, 0x0, Serialized) {
					Name (RBUF, ResourceTemplate () {
						Memory32Fixed (ReadWrite, 0x1c070000, 0x00010000)
						Interrupt (ResourceConsumer, Edge, ActiveBoth,
								Exclusive, , , ) {45}
					})
					Return (RBUF)
				}
			}

			Device (SER0) {
				Name (_ADR,0x1c090000)                         // UART0
				Method (_CRS, 0x0, Serialized) {
					Name (RBUF, ResourceTemplate () {
						Memory32Fixed (ReadWrite, 0x1c090000, 0x00010000)
						Interrupt (ResourceConsumer, Edge, ActiveBoth,
								Exclusive, , , ) {37}
					})
					Return (RBUF)
				}
			}

			Device (SER1) {
				Name (_ADR,0x1c0a0000)                         // UART1
				Method (_CRS, 0x0, Serialized) {
					Name (RBUF, ResourceTemplate () {
						Memory32Fixed (ReadWrite, 0x1c0a0000, 0x00010000)
						Interrupt (ResourceConsumer, Edge, ActiveBoth,
								Exclusive, , , ) {38}
					})
					Return (RBUF)
				}
			}
			Device (SER2) {
				Name (_ADR,0x1c0b0000)                         // UART2
				Method (_CRS, 0x0, Serialized) {
					Name (RBUF, ResourceTemplate () {
						Memory32Fixed (ReadWrite, 0x1c0b0000, 0x00010000)
						Interrupt (ResourceConsumer, Edge, ActiveBoth,
								Exclusive, , , ) {39}
					})
					Return (RBUF)
				}
			}

			Device (SER3) {
				Name (_ADR,0x1c0c0000)                         // UART3
				Method (_CRS, 0x0, Serialized) {
					Name (RBUF, ResourceTemplate () {
						Memory32Fixed (ReadWrite, 0x1c0c0000, 0x00010000)
						Interrupt (ResourceConsumer, Edge, ActiveBoth,
								Exclusive, , , ) {40}
					})
					Return (RBUF)
				}
			}
		}


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
