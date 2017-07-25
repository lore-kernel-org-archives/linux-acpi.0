From: Lukas Wunner <lukas@wunner.de>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Tue, 25 Jul 2017 12:37:34 +0200
Message-ID: <20170725103734.GA5998@wunner.de>
References: <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
 <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
 <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
 <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
 <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>
 <c1ed89a5-e6a1-1903-05ee-a9dfcdb2ef61@butterbrot.org>
 <20170717090235.GB3993@wunner.de>
 <29cdd744-8fac-557b-bc5f-087e84adcae7@butterbrot.org>
 <fdd1f9fa-f4a5-3b3b-0a0b-8bbff0ef2e5f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:45209 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdGYKh1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jul 2017 06:37:27 -0400
Content-Disposition: inline
In-Reply-To: <fdd1f9fa-f4a5-3b3b-0a0b-8bbff0ef2e5f@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: Florian Echtler <floe@butterbrot.org>, Alex Deucher <alexdeucher@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org

On Tue, Jul 25, 2017 at 07:14:23AM +0200, Mario Kleiner wrote:
> On 07/24/2017 03:45 PM, Florian Echtler wrote:
> > thanks for the hint. I've applied this patch to the v4.12 tree I'm
> > currently running, and it didn't seem to make any difference (i.e.
> > display stays black after suspend).
> 
> That's the same here with my patch applied. After a suspend -> resume, the
> internal panel stays black, the patch doesn't help for that. Somethig i
> didn't notice btw., apparently i never suspend->resumed it.
[...]
> Lukas idea that some hardware mux gets switched into the wrong position on
> models with TDM sounds pretty appealing to me, but how to test?

If all else fails, with a multimeter / oscilloscope. :-)  The board
schematics are available by googling for the right terms, such as
the drawing number "051-7863" and internal codename "K23".

Of interest is the eDP connector on the mainboard, page 90.  Notice
there are two power rails going into it, 3.3V (pin 31) and 12V (pins
27 - 30).  Florian obtained dmesg output of the machine coming out
of suspend by ssh'ing into it and it showed that the eDP link could
be trained properly upon system resume.  Still the panel stayed black.

My guess is that the panel's DisplayPort transceiver is powered via the
3.3V rail.  This rail is powered permanently when the system is in S0,
it cannot be switched off at runtime.  So, the Radeon card can talk to
the DisplayPort transceiver (which has power) but the 12V rail, which
presumably powers the LED backlight, is off.  You could test this theory
by attaching a multimeter after coming out of suspend:  You should see
a voltage difference of 3.3V between pins 31 and 32 (ground) and 0V
between pins 27 - 30 and 32.

The logic for the 12V rail is somewhat complicated, first there's
pin 21 ("VIDEO_ON"), this seems to come *from* the panel and presumably
signals that the link is trained. This should go high after resume.
If it does not then maybe a write to a custom DPCD register is necessary
to make it go high.  If this pin stays low then the 12V rail is not
powered.

Next there's a 74LVC157A mux (page 95 top-left).  Datasheet:
https://assets.nexperia.com/documents/data-sheet/74LVC157A.pdf
The mux can switch four wires, but Apple only needed three.
I guess all outputs (pins 7, 9, 12) must be high for the backlight
to go on.  The mux is under the control of the SMC and is presumably
switched by issuing appropriate commands to the SMC.  It's unclear
to me if the SMC has switched it to the Radeon or to the TDM source
after resume.

Assuming that the mux is switched to the Radeon card, follow input
pins 5, 10 and 14 (MXM_PNL_BL_PWM, MXM_PNL_BL_EN, MXM_PNL_PWR_EN).
They are coming from a "system management" block on the Radeon card
(pins 25, 27, 23, page 85).  Apparently these are GPIO pins for
OEM use and I guess they can be controlled by writing to the PCI BAR
of the Radeon card, but I've no idea at what address their registers
might be located.  I'll try to look at the macOS Radeon drivers with
a disassembler but this is like looking for a needle in a haystack.


> However this is something i got when connecting the external Displayport
> panel:
> 
> Jul  7 04:16:09 kleinerm-MaxtorLinux kernel: [ 1441.344792]
> [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
> Jul  7 04:16:09 kleinerm-MaxtorLinux kernel: [ 1441.344819]
> [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
> Jul  7 04:18:07 kleinerm-MaxtorLinux kernel: [ 1559.770783]
> drm_dp_i2c_do_msg: 20 callbacks suppressed
> Jul  7 04:30:19 kleinerm-MaxtorLinux kernel: [ 2291.143406]
> [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
> Jul  7 04:30:19 kleinerm-MaxtorLinux kernel: [ 2291.143439]
> [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
> Jul  7 04:30:19 kleinerm-MaxtorLinux kernel: [ 2291.356173]
> [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
> Jul  7 04:30:19 kleinerm-MaxtorLinux kernel: [ 2291.356205]
> [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
> 
> So link training failed, because drm_dp_dpcd_read_link_status() already
> failed to read from the dp aux channel.

The AUX channel can be terminated in either of two modes under the control
of the SMC:  100k source termination or weak sink termination (page 94/95).
Failure to communicate over AUX may be explained by being in the incorrect
mode.

HTH,

Lukas
