From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [RFC PATCH 0/3] ACPI: ARM AMBA bus connector resource
Date: Tue, 22 Oct 2013 09:42:51 +0100
Message-ID: <20131022084251.GB1662@xora-yoga-vm.localdomain>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:38077 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab3JVIua (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Oct 2013 04:50:30 -0400
Received: by mail-wg0-f48.google.com with SMTP id b13so7698786wgh.15
        for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2013 01:50:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: brandon.anderson@amd.com
Cc: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, naresh.bhat@linaro.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com

Hi Brandon,

Haven't had time for a deep review yet, but I am liking the direction o=
f
these patches.

Thanks

Graeme

On Mon, Oct 21, 2013 at 07:33:46PM -0500, brandon.anderson@amd.com wrot=
e:
> From: Brandon Anderson <brandon.anderson@amd.com>
>=20
> This is a proposal for ACPI driver probing of the ARM AMBA devices cu=
rrently listed under =E2=80=98iofpga=E2=80=99 in the RTSM dts file. The=
 main addition is drivers/amba/acpi.c which fits the role of an AMBA bu=
s =E2=80=98connector resource=E2=80=99 for ACPI using struct amba_devic=
e.
>=20
> I have not yet figured out the implementation details regarding clock=
s (handled in the dts file with clock-names). However, I have included =
a proposed ASL format for clock information in the DSDT example below. =
With the last patch that hacks the clock info, this prototype will run =
on the Foundation and RTSM models.
>=20
> These patches require Hanjun=E2=80=99s fixed-clock patches to be appl=
ied first on top of a Linaro ACPI kernel: https://git.linaro.org/gitweb=
?p=3Darm/acpi/leg-kernel.git;a=3Dsummary
>=20
> Please comment on both the concept and the implementation.
>=20
> Brandon Anderson (3):
>   Remove UART and KMI entries from DTS file
>   Prototype of AMBA bus 'connector resource' for ACPI
>   Hack clock names to get prototype running
>=20
>  arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +-
>  arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 +
>  arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    4 +
>  drivers/acpi/acpi_platform.c                      |    2 +
>  drivers/amba/Makefile                             |    2 +-
>  drivers/amba/acpi.c                               |  172 +++++++++++=
++++++++++
>  drivers/clk/clk-fixed-rate.c                      |   15 +-
>  7 files changed, 203 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/amba/acpi.c
>=20
> --=20
> 1.7.9.5
>=20
>=20
> ---
>=20
> 		Device (AMBA) {
> 			Name (_HID, "AMBA0000") /* the parallel to "arm,primecell" in DTS =
*/
> 			Name (_UID, 0)
>=20
> 			/* Define 'apb_pclk' as a default clock source since it is
> 			   common with devices below */
> 			Method(_DSM, 4, NotSerialized) {
> 				Store (Package (3)
> 				{
> 					"clock-name", "apb_pclk", "\\_SB_.CLK0",
> 				}, Local0)
>=20
> 				Return (Local0)
> 			}
>=20
> 			Device (KMI0) {
> 				Name (_ADR,0x1c060000)
> 				Method (_CRS, 0x0, Serialized) {
> 					Name (RBUF, ResourceTemplate () {
> 						Memory32Fixed (ReadWrite, 0x1c060000, 0x00010000)
> 						Interrupt (ResourceConsumer, Edge, ActiveBoth,
> 								Exclusive, , , ) {44}
> 					})
> 					Return (RBUF)
> 				}
> 			}
>=20
> 			Device (KMI1) {
> 				Name (_ADR,0x1c070000)
> 				Method (_CRS, 0x0, Serialized) {
> 					Name (RBUF, ResourceTemplate () {
> 						Memory32Fixed (ReadWrite, 0x1c070000, 0x00010000)
> 						Interrupt (ResourceConsumer, Edge, ActiveBoth,
> 								Exclusive, , , ) {45}
> 					})
> 					Return (RBUF)
> 				}
> 			}
>=20
> 			Device (SER0) {
> 				Name (_ADR,0x1c090000)                         // UART0
> 				Method (_CRS, 0x0, Serialized) {
> 					Name (RBUF, ResourceTemplate () {
> 						Memory32Fixed (ReadWrite, 0x1c090000, 0x00010000)
> 						Interrupt (ResourceConsumer, Edge, ActiveBoth,
> 								Exclusive, , , ) {37}
> 					})
> 					Return (RBUF)
> 				}
> 			}
>=20
> 			Device (SER1) {
> 				Name (_ADR,0x1c0a0000)                         // UART1
> 				Method (_CRS, 0x0, Serialized) {
> 					Name (RBUF, ResourceTemplate () {
> 						Memory32Fixed (ReadWrite, 0x1c0a0000, 0x00010000)
> 						Interrupt (ResourceConsumer, Edge, ActiveBoth,
> 								Exclusive, , , ) {38}
> 					})
> 					Return (RBUF)
> 				}
> 			}
> 			Device (SER2) {
> 				Name (_ADR,0x1c0b0000)                         // UART2
> 				Method (_CRS, 0x0, Serialized) {
> 					Name (RBUF, ResourceTemplate () {
> 						Memory32Fixed (ReadWrite, 0x1c0b0000, 0x00010000)
> 						Interrupt (ResourceConsumer, Edge, ActiveBoth,
> 								Exclusive, , , ) {39}
> 					})
> 					Return (RBUF)
> 				}
> 			}
>=20
> 			Device (SER3) {
> 				Name (_ADR,0x1c0c0000)                         // UART3
> 				Method (_CRS, 0x0, Serialized) {
> 					Name (RBUF, ResourceTemplate () {
> 						Memory32Fixed (ReadWrite, 0x1c0c0000, 0x00010000)
> 						Interrupt (ResourceConsumer, Edge, ActiveBoth,
> 								Exclusive, , , ) {40}
> 					})
> 					Return (RBUF)
> 				}
> 			}
> 		}
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
