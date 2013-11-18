From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/12] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
Date: Mon, 18 Nov 2013 14:24:01 +0100
Message-ID: <2429527.tRrfhbW41X@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <76934632.melfpCVyMM@vostro.rjw.lan> <CAGHbJ3ArVr+4g8UHyxFSL9Bu2ehsUAqsapGuxYLgfoR4NfT02w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54193 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751167Ab3KRNL0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2013 08:11:26 -0500
In-Reply-To: <CAGHbJ3ArVr+4g8UHyxFSL9Bu2ehsUAqsapGuxYLgfoR4NfT02w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Al Stone <al.stone@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <ahs3@redhat.com>

On Monday, November 18, 2013 08:48:05 PM Hanjun Guo wrote:
> On 18 November 2013 06:29, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > On Saturday, November 09, 2013 06:36:11 PM al.stone@linaro.org wrote:
> > > From: Al Stone <ahs3@redhat.com>
> > >
> > > To enable the hardware reduced mode of ACPI on some platforms (such as
> > > ARM), we need to modify the kernel code and set ACPI_REDUCED_HARDWARE
> > > to TRUE in the ACPICA source.
> > >
> > > This can be done more resonably by introducing a kernel config item
> > > to enable/disable ACPI_REDUCED_HARDWARE.  We can then change the kernel
> > > config instead of having to modify the kernel source directly to enable
> > > the reduced hardware mode of ACPI.
> > >
> > > Lv Zheng suggested that this configuration item does not belong in
> > ACPICA,
> > > the upstream source for much of the ACPI internals, but rather to the
> > > Linux kernel itself.  Hence, we introduce this flag so that we can make
> > > ACPI_REDUCED_HARDWARE configurable.  For the details of the discussion,
> > > please refer to: http://www.spinics.net/lists/linux-acpi/msg46369.html
> > >
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > Signed-off-by: Al Stone <al.stone@linaro.org>
> > > ---
> > >  drivers/acpi/Kconfig            | 8 ++++++++
> > >  include/acpi/platform/aclinux.h | 4 ++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > index 589da05..7bbd3b0 100644
> > > --- a/drivers/acpi/Kconfig
> > > +++ b/drivers/acpi/Kconfig
> > > @@ -354,6 +354,14 @@ config ACPI_BGRT
> > >         data from the firmware boot splash. It will appear under
> > >         /sys/firmware/acpi/bgrt/ .
> > >
> > > +config ACPI_REDUCED_HARDWARE
> > > +     bool "Hardware-reduced ACPI support"
> > > +     depends on !(IA64 || X86)
> >
> > Why don't you use
> >
> >         depends on (ARM || ARM64)
> >
> > here instead?
> >
> 
> hardware-reduced is not restricted to ARM platforms, that's why
> 
> I used depends on !(IA64 || X86) here.

So what exactly are the other platforms using ACPI in the Linux kernel?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
