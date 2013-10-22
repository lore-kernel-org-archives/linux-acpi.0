From: Naresh Bhat <naresh.bhat@linaro.org>
Subject: Re: [RFC PATCH 0/3] ACPI: ARM AMBA bus connector resource
Date: Tue, 22 Oct 2013 14:49:14 +0530
Message-ID: <CAFoFrHb3cMgVx-xJBNiUG8pqdyrOPxXpo5kOZ2uZt88LhAX+Rg@mail.gmail.com>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
	<CAFoFrHY0vR5T0rX80UHQWcuAUPQdshz3TrQ5Eh3F7utrV9Yutg@mail.gmail.com>
	<20131022084149.GA1662@xora-yoga-vm.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34857 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab3JVJTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Oct 2013 05:19:15 -0400
Received: by mail-oa0-f50.google.com with SMTP id j1so7697840oag.37
        for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2013 02:19:14 -0700 (PDT)
In-Reply-To: <20131022084149.GA1662@xora-yoga-vm.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: "Anderson, Brandon" <brandon.anderson@amd.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Hanjun Guo <hanjun.guo@linaro.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

Hi Graeme,

I have't seen any.  Can you please forward me if you have got in your i=
nbox.

-Naresh

On 22 October 2013 14:11, Graeme Gregory <graeme.gregory@linaro.org> wr=
ote:
> Hi Naresh,
>
> Isn't the ASL in the first post of the series?
>
> Graeme
>
> On Tue, Oct 22, 2013 at 01:50:32PM +0530, Naresh Bhat wrote:
>> Hi Anderson,
>>
>> The patches applied, compiled (except there was a conflict in the la=
st
>> patch "Hack clock names to get prototype running").  Can you please
>> post the ASL code changes patch ? looks like ASL changes are differe=
nt
>> from what we have written originally.
>>
>> -Naresh
>>
>>
>> On 22 October 2013 06:03,  <brandon.anderson@amd.com> wrote:
>> > From: Brandon Anderson <brandon.anderson@amd.com>
>> >
>> > This is a proposal for ACPI driver probing of the ARM AMBA devices=
 currently listed under =91iofpga=92 in the RTSM dts file. The main add=
ition is drivers/amba/acpi.c which fits the role of an AMBA bus =91conn=
ector resource=92 for ACPI using struct amba_device.
>> >
>> > I have not yet figured out the implementation details regarding cl=
ocks (handled in the dts file with clock-names). However, I have includ=
ed a proposed ASL format for clock information in the DSDT example belo=
w. With the last patch that hacks the clock info, this prototype will r=
un on the Foundation and RTSM models.
>> >
>> > These patches require Hanjun=92s fixed-clock patches to be applied=
 first on top of a Linaro ACPI kernel: https://git.linaro.org/gitweb?p=3D=
arm/acpi/leg-kernel.git;a=3Dsummary
>> >
>> > Please comment on both the concept and the implementation.
>> >
>> > Brandon Anderson (3):
>> >   Remove UART and KMI entries from DTS file
>> >   Prototype of AMBA bus 'connector resource' for ACPI
>> >   Hack clock names to get prototype running
>> >
>> >  arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +-
>> >  arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 +
>> >  arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    4 +
>> >  drivers/acpi/acpi_platform.c                      |    2 +
>> >  drivers/amba/Makefile                             |    2 +-
>> >  drivers/amba/acpi.c                               |  172 ++++++++=
+++++++++++++
>> >  drivers/clk/clk-fixed-rate.c                      |   15 +-
>> >  7 files changed, 203 insertions(+), 6 deletions(-)
>> >  create mode 100644 drivers/amba/acpi.c
>> >
>> > --
>> > 1.7.9.5
>> >
>> >
>> > ---
>> >
>> >                 Device (AMBA) {
>> >                         Name (_HID, "AMBA0000") /* the parallel to=
 "arm,primecell" in DTS */
>> >                         Name (_UID, 0)
>> >
>> >                         /* Define 'apb_pclk' as a default clock so=
urce since it is
>> >                            common with devices below */
>> >                         Method(_DSM, 4, NotSerialized) {
>> >                                 Store (Package (3)
>> >                                 {
>> >                                         "clock-name", "apb_pclk", =
"\\_SB_.CLK0",
>> >                                 }, Local0)
>> >
>> >                                 Return (Local0)
>> >                         }
>> >
>> >                         Device (KMI0) {
>> >                                 Name (_ADR,0x1c060000)
>> >                                 Method (_CRS, 0x0, Serialized) {
>> >                                         Name (RBUF, ResourceTempla=
te () {
>> >                                                 Memory32Fixed (Rea=
dWrite, 0x1c060000, 0x00010000)
>> >                                                 Interrupt (Resourc=
eConsumer, Edge, ActiveBoth,
>> >                                                                 Ex=
clusive, , , ) {44}
>> >                                         })
>> >                                         Return (RBUF)
>> >                                 }
>> >                         }
>> >
>> >                         Device (KMI1) {
>> >                                 Name (_ADR,0x1c070000)
>> >                                 Method (_CRS, 0x0, Serialized) {
>> >                                         Name (RBUF, ResourceTempla=
te () {
>> >                                                 Memory32Fixed (Rea=
dWrite, 0x1c070000, 0x00010000)
>> >                                                 Interrupt (Resourc=
eConsumer, Edge, ActiveBoth,
>> >                                                                 Ex=
clusive, , , ) {45}
>> >                                         })
>> >                                         Return (RBUF)
>> >                                 }
>> >                         }
>> >
>> >                         Device (SER0) {
>> >                                 Name (_ADR,0x1c090000)            =
             // UART0
>> >                                 Method (_CRS, 0x0, Serialized) {
>> >                                         Name (RBUF, ResourceTempla=
te () {
>> >                                                 Memory32Fixed (Rea=
dWrite, 0x1c090000, 0x00010000)
>> >                                                 Interrupt (Resourc=
eConsumer, Edge, ActiveBoth,
>> >                                                                 Ex=
clusive, , , ) {37}
>> >                                         })
>> >                                         Return (RBUF)
>> >                                 }
>> >                         }
>> >
>> >                         Device (SER1) {
>> >                                 Name (_ADR,0x1c0a0000)            =
             // UART1
>> >                                 Method (_CRS, 0x0, Serialized) {
>> >                                         Name (RBUF, ResourceTempla=
te () {
>> >                                                 Memory32Fixed (Rea=
dWrite, 0x1c0a0000, 0x00010000)
>> >                                                 Interrupt (Resourc=
eConsumer, Edge, ActiveBoth,
>> >                                                                 Ex=
clusive, , , ) {38}
>> >                                         })
>> >                                         Return (RBUF)
>> >                                 }
>> >                         }
>> >                         Device (SER2) {
>> >                                 Name (_ADR,0x1c0b0000)            =
             // UART2
>> >                                 Method (_CRS, 0x0, Serialized) {
>> >                                         Name (RBUF, ResourceTempla=
te () {
>> >                                                 Memory32Fixed (Rea=
dWrite, 0x1c0b0000, 0x00010000)
>> >                                                 Interrupt (Resourc=
eConsumer, Edge, ActiveBoth,
>> >                                                                 Ex=
clusive, , , ) {39}
>> >                                         })
>> >                                         Return (RBUF)
>> >                                 }
>> >                         }
>> >
>> >                         Device (SER3) {
>> >                                 Name (_ADR,0x1c0c0000)            =
             // UART3
>> >                                 Method (_CRS, 0x0, Serialized) {
>> >                                         Name (RBUF, ResourceTempla=
te () {
>> >                                                 Memory32Fixed (Rea=
dWrite, 0x1c0c0000, 0x00010000)
>> >                                                 Interrupt (Resourc=
eConsumer, Edge, ActiveBoth,
>> >                                                                 Ex=
clusive, , , ) {40}
>> >                                         })
>> >                                         Return (RBUF)
>> >                                 }
>> >                         }
>> >                 }
>> >
>> >
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
