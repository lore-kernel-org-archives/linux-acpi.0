From: Naresh Bhat <naresh.bhat@linaro.org>
Subject: Re: [RFC PATCH 0/3] ACPI: ARM AMBA bus connector resource
Date: Tue, 22 Oct 2013 13:50:32 +0530
Message-ID: <CAFoFrHY0vR5T0rX80UHQWcuAUPQdshz3TrQ5Eh3F7utrV9Yutg@mail.gmail.com>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:36642 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab3JVIUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Oct 2013 04:20:33 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so6193846oag.31
        for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2013 01:20:32 -0700 (PDT)
In-Reply-To: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Anderson, Brandon" <brandon.anderson@amd.com>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

Hi Anderson,

The patches applied, compiled (except there was a conflict in the last
patch "Hack clock names to get prototype running").  Can you please
post the ASL code changes patch ? looks like ASL changes are different
from what we have written originally.

-Naresh


On 22 October 2013 06:03,  <brandon.anderson@amd.com> wrote:
> From: Brandon Anderson <brandon.anderson@amd.com>
>
> This is a proposal for ACPI driver probing of the ARM AMBA devices cu=
rrently listed under =91iofpga=92 in the RTSM dts file. The main additi=
on is drivers/amba/acpi.c which fits the role of an AMBA bus =91connect=
or resource=92 for ACPI using struct amba_device.
>
> I have not yet figured out the implementation details regarding clock=
s (handled in the dts file with clock-names). However, I have included =
a proposed ASL format for clock information in the DSDT example below. =
With the last patch that hacks the clock info, this prototype will run =
on the Foundation and RTSM models.
>
> These patches require Hanjun=92s fixed-clock patches to be applied fi=
rst on top of a Linaro ACPI kernel: https://git.linaro.org/gitweb?p=3Da=
rm/acpi/leg-kernel.git;a=3Dsummary
>
> Please comment on both the concept and the implementation.
>
> Brandon Anderson (3):
>   Remove UART and KMI entries from DTS file
>   Prototype of AMBA bus 'connector resource' for ACPI
>   Hack clock names to get prototype running
>
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
>
> --
> 1.7.9.5
>
>
> ---
>
>                 Device (AMBA) {
>                         Name (_HID, "AMBA0000") /* the parallel to "a=
rm,primecell" in DTS */
>                         Name (_UID, 0)
>
>                         /* Define 'apb_pclk' as a default clock sourc=
e since it is
>                            common with devices below */
>                         Method(_DSM, 4, NotSerialized) {
>                                 Store (Package (3)
>                                 {
>                                         "clock-name", "apb_pclk", "\\=
_SB_.CLK0",
>                                 }, Local0)
>
>                                 Return (Local0)
>                         }
>
>                         Device (KMI0) {
>                                 Name (_ADR,0x1c060000)
>                                 Method (_CRS, 0x0, Serialized) {
>                                         Name (RBUF, ResourceTemplate =
() {
>                                                 Memory32Fixed (ReadWr=
ite, 0x1c060000, 0x00010000)
>                                                 Interrupt (ResourceCo=
nsumer, Edge, ActiveBoth,
>                                                                 Exclu=
sive, , , ) {44}
>                                         })
>                                         Return (RBUF)
>                                 }
>                         }
>
>                         Device (KMI1) {
>                                 Name (_ADR,0x1c070000)
>                                 Method (_CRS, 0x0, Serialized) {
>                                         Name (RBUF, ResourceTemplate =
() {
>                                                 Memory32Fixed (ReadWr=
ite, 0x1c070000, 0x00010000)
>                                                 Interrupt (ResourceCo=
nsumer, Edge, ActiveBoth,
>                                                                 Exclu=
sive, , , ) {45}
>                                         })
>                                         Return (RBUF)
>                                 }
>                         }
>
>                         Device (SER0) {
>                                 Name (_ADR,0x1c090000)               =
          // UART0
>                                 Method (_CRS, 0x0, Serialized) {
>                                         Name (RBUF, ResourceTemplate =
() {
>                                                 Memory32Fixed (ReadWr=
ite, 0x1c090000, 0x00010000)
>                                                 Interrupt (ResourceCo=
nsumer, Edge, ActiveBoth,
>                                                                 Exclu=
sive, , , ) {37}
>                                         })
>                                         Return (RBUF)
>                                 }
>                         }
>
>                         Device (SER1) {
>                                 Name (_ADR,0x1c0a0000)               =
          // UART1
>                                 Method (_CRS, 0x0, Serialized) {
>                                         Name (RBUF, ResourceTemplate =
() {
>                                                 Memory32Fixed (ReadWr=
ite, 0x1c0a0000, 0x00010000)
>                                                 Interrupt (ResourceCo=
nsumer, Edge, ActiveBoth,
>                                                                 Exclu=
sive, , , ) {38}
>                                         })
>                                         Return (RBUF)
>                                 }
>                         }
>                         Device (SER2) {
>                                 Name (_ADR,0x1c0b0000)               =
          // UART2
>                                 Method (_CRS, 0x0, Serialized) {
>                                         Name (RBUF, ResourceTemplate =
() {
>                                                 Memory32Fixed (ReadWr=
ite, 0x1c0b0000, 0x00010000)
>                                                 Interrupt (ResourceCo=
nsumer, Edge, ActiveBoth,
>                                                                 Exclu=
sive, , , ) {39}
>                                         })
>                                         Return (RBUF)
>                                 }
>                         }
>
>                         Device (SER3) {
>                                 Name (_ADR,0x1c0c0000)               =
          // UART3
>                                 Method (_CRS, 0x0, Serialized) {
>                                         Name (RBUF, ResourceTemplate =
() {
>                                                 Memory32Fixed (ReadWr=
ite, 0x1c0c0000, 0x00010000)
>                                                 Interrupt (ResourceCo=
nsumer, Edge, ActiveBoth,
>                                                                 Exclu=
sive, , , ) {40}
>                                         })
>                                         Return (RBUF)
>                                 }
>                         }
>                 }
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
