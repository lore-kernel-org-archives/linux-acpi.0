From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Mon, 15 Jan 2007 16:33:54 +0300
Message-ID: <E3C0BCA40296C347AF7142161DB9FC8298F74B@mssmsx411>
References: <200701132224.59596.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C738A9.CD650F3D"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37234 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbXAONeA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jan 2007 08:34:00 -0500
Content-class: urn:content-classes:message
In-Reply-To: <200701132224.59596.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Matthew Brett <matthew.brett@gmail.com>
Cc: Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C738A9.CD650F3D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

>I think there are two things being confused here:
>
	............
>
>  2) Salatiel's report, which is rather vague: "I think my fans
>     are not working in Linux."  I haven't seen Salatiel's acpidump,
>     but Konstantin says it has no fan devices and no active trip
>     points.  Since Salatiel has no PNP0C0B device, his problem is
>     unrelated to the fan.ko driver.
>

Right, and later we've find out that the fan on Salatiel's system being
turned on by hardware at the point of 80C.

>So let's concentrate on Matthew's problem first.  Loading fan.ko
>turns off the fan.  If the machine is cool, as it likely is at
>boot-time, this might be appropriate.
>

Yes, this is possible...

>When the system gets hot, the thermal driver is supposed to turn
>the fan(s) on, and this doesn't seem to happen.  But the experiments
>Konstantin suggested showed that the thermal driver did notice the
>temperature above the active trip point, it switched to active
>cooling, and ACPI claims the fan is on, thought it apparently is
>not.

Well, here is the excerpt from decompiled Matthew's DSDT:

               PowerResource (FN01, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x01)
                    }

                    Method (_ON, 0, NotSerialized)
                    {
                        \_SB.PCI0.LPC0.SIO.WR00 (0x07, 0x0A)
                        \_SB.PCI0.LPC0.SIO.WR00 (0x30, 0x01)
                        Store (0x7E, \FAN1)
                        Store (0x7E, \FAN2)
                        Store (0x01, \_TZ.THRM.FNON)
                        Notify (\_TZ.THRM, 0x81)
                        Store (0xCC, DBGP)
                        \_SB.PCI0.LPC0.SIO.WR00 (0x30, 0x00)
                    }

                    Method (_OFF, 0, NotSerialized)
                    {
                        \_SB.PCI0.LPC0.SIO.WR00 (0x07, 0x0A)
                        \_SB.PCI0.LPC0.SIO.WR00 (0x30, 0x01)
                        Store (0x04, \FAN1)
                        Store (0x6A, \FAN2)
                        Store (0x00, \_TZ.THRM.FNON)
                        Notify (\_TZ.THRM, 0x81)
                        Store (0xDD, DBGP)
                        \_SB.PCI0.LPC0.SIO.WR00 (0x30, 0x00)
                    }
                }

                Device (FAN1)
                {
                    Name (_HID, EisaId ("PNP0C0B"))
                    Name (_UID, 0x01)
                    Name (_PR0, Package (0x01)
                    {
                        FN01
                    })
                }

The fan device FAN1 defines object FN01 as its power resource. _STA
method of FN01 always return 0x01, i.e. resource is on. So the fan
driver is unable to turn the fan on, because it thinks that it is
already in that state.

But, _ON and _OFF methods set \_TZ.THRM.FNON object to 1 and 0
respectively, so, I think, it could be used as value returned by _STA
method. Attached patch for DSDT should solve the fan issue.


Regards.
Konstantin.
>-----Original Message-----
>From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
>Sent: Sunday, January 14, 2007 8:25 AM
>To: Alexey Starikovskiy
>Cc: Matthew Brett; Karasyov, Konstantin A; Salatiel Filho; linux-
>acpi@vger.kernel.org
>Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel
2.6.18
>and later
>
>On Saturday 13 January 2007 08:51, Alexey Starikovskiy wrote:
>> Matthew Brett wrote:
>> >> If BIOS does not export fan controls to OS via DSDT, it means that
>BIOS
>> >> wants to control fans via its own means (hardware), this doesn't
mean
>> >> that your machine is at risk, it only means that you are not
allowed
>to
>> >> tamper with it...
>> >
>> > Well, except the original poster complained that linux but not
windows
>> > was shutting down the fan - meaning - surely - that somehow linux
is
>> > tampering with the fan when it should not.
>> >
>> As it was said above, Linux has no means to do that. At least through
>> ACPI framework.
>
>I think there are two things being confused here:
>
>  1) Matthew's report, which clearly says that loading fan.ko
>     turns off the fan, and it doesn't come back on when it should.
>     His BIOS provides a PNP0C0B fan device and an _AC0 trip point,
>     so Linux *should* be able to control the fan.
>
>  2) Salatiel's report, which is rather vague: "I think my fans
>     are not working in Linux."  I haven't seen Salatiel's acpidump,
>     but Konstantin says it has no fan devices and no active trip
>     points.  Since Salatiel has no PNP0C0B device, his problem is
>     unrelated to the fan.ko driver.
>
>So let's concentrate on Matthew's problem first.  Loading fan.ko
>turns off the fan.  If the machine is cool, as it likely is at
>boot-time, this might be appropriate.
>
>When the system gets hot, the thermal driver is supposed to turn
>the fan(s) on, and this doesn't seem to happen.  But the experiments
>Konstantin suggested showed that the thermal driver did notice the
>temperature above the active trip point, it switched to active
>cooling, and ACPI claims the fan is on, thought it apparently is
>not.
>
>Are there any messages in dmesg about problems turning on cooling
>devices?
>
>With 2.6.17, loading fan.ko leaves the fan on.  Manually turning
>off the fan works.  But manually turning it back on again fails,
>which looks suspiciously like the 2.6.20-rc3 problem where the
>thermal driver can't turn the fan on again.
>
>Maybe there's some firmware or mechanical problem such that the
>fan can only be turned on via reset or a power cycle?  Does the
>fan *ever* turn off and then back on again under 2.6.17?  I don't
>suppose you can try this under Windows?  Vacuum out the dust
>bunnies?  Try a different fan?
>
>Bjorn

------_=_NextPart_001_01C738A9.CD650F3D
Content-Type: application/octet-stream;
	name="dsdt_fan.patch"
Content-Transfer-Encoding: base64
Content-Description: dsdt_fan.patch
Content-Disposition: attachment;
	filename="dsdt_fan.patch"

LS0tIERTRFQuZHNsCTIwMDctMDEtMTUgMTU6MjM6NTIuMDAwMDAwMDAwICswMzAwCisrKyBuZXdf
RFNEVC5kc2wJMjAwNy0wMS0xNSAxNTo0NjoyNC4wMDAwMDAwMDAgKzAzMDAKQEAgLTExNCw3ICsx
MTQsNyBAQAogICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgTWV0aG9kIChf
U1RBLCAwLCBOb3RTZXJpYWxpemVkKQogICAgICAgICAgICAgICAgICAgICB7Ci0gICAgICAgICAg
ICAgICAgICAgICAgICBSZXR1cm4gKDB4MDEpCisgICAgICAgICAgICAgICAgICAgICAgICBSZXR1
cm4gKFxfVFouVEhSTS5GTk9OKQogICAgICAgICAgICAgICAgICAgICB9CiAKICAgICAgICAgICAg
ICAgICAgICAgTWV0aG9kIChfT04sIDAsIE5vdFNlcmlhbGl6ZWQpCg==

------_=_NextPart_001_01C738A9.CD650F3D--
