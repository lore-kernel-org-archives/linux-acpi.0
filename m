From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH -mm] ACPI video: only one ACPI bus video device is allowed
 for one VGA controller
Date: Thu, 16 Jul 2009 14:10:29 +0200
Message-ID: <4A5F18B5.30503@marcansoft.com>
References: <1247649488.26272.106.camel@rzhang-dt> <20090715143103.GB22098@khazad-dum.debian.net> <4A5E5148.808@marcansoft.com> <1247711879.26272.186.camel@rzhang-dt> <20090716114949.GB11928@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:49525 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbZGPMKc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jul 2009 08:10:32 -0400
In-Reply-To: <20090716114949.GB11928@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Henrique de Moraes Holschuh wrote:
>> But the bug that I want to fix in this patch is that,
>> there are two ACPI video bus devices
>> \_SB.PCI0.GFX0.VID1
>> ???\_SB.PCI0.GFX0.VID2
>> both are active because PCI device GFX0 exists, and ACPI tries to bind
>> all these two devices to ACPI video driver.
>> it's meaningless to have two ACPI video bus device for one VGA
>> controller, right?
> 
> Unless your ACPI tables control each CRTC of the device separately... most
> GPUs have at least two CRTCs nowadats, and that might mean two backlight
> controllers as well, btw.  But this doesn't look like what happens on the
> platform with the bug by the descriptions in this thread, and I know of no
> device that would try to do something as crazy as what I described (if it is
> allowed at all by the ACPI spec, which I didn't check)...

VID1 and VID2 each are "video bus devices" and have children for each
output device. Both have an LCD panel output device and both panels have
backlight controls. Both backlight controls control the same hardware.

The ACPI code in Linux already has support for this extra level of
nesting (if _ADR is zero it checks to see if the parent represents the
actual PCI device). The issue is that there are *two* children under the
same PCI device. As far as Linux support goes, they are basically
equivalent.

> If you had *two* backlight controllers, that should just mean you are to
> step them up/down together, nothing else...  However, if they handle the
> same brightness hardware, yes, it _will_ cause problems (double stepping,
> for example).

Right, they do. This is why one needs to be disabled.

I don't think the patch should cause any issues because it ought to only
disable extra devices that fall under the same parent PCI device. I
don't think getting two video bus devices for one PCI device is sane in
any instance.

Here's the actual example from my DSDT:
-------------------------------------------------------------
Device (PEGP)
{
	Name (_ADR, 0x00010000)
	Device (EVGA)
	{
		Name (_ADR, Zero)
		[...]

		Device (CRT)
		{
			[...]
		}

		Device (LCD)
		{
			[...]
			[backlight support here]
		}

		Device (TV)
		{
			[...]
		}
	}

	Device (NVGA)
	{
		Name (_ADR, Zero)
		[...]
		Device (CRT0)
		{
			[...]
		}

		Device (LCD0)
		{
			[...]
			[backlight support here]
		}

		Device (HDV0)
		{
			[...]
		}
		[some extra methods]
	}
	[...]
}

Device (OVGA)
{
	Name (_ADR, 0x00020000)
	[...]
	Device (CRT1)
	{
		[...]
	}

	Device (DTV1)
	{
		[...]
	}

	Device (LCD)
	{
		[...]
		[backlight support here]
	}

	Device (DD01)
	{
		[...]
	}

	Device (DD02)
	{
		[...]
		
	}

	Device (DD03)
	{
		[...]
		
	}

	Device (DD04)
	{
		[...]
	}

	Device (DD05)
	{
		[...]
	}
	[...]
}
-------------------------------------------------------------

As you can see, I have three video bus devices (each with subdevices for
the multiple output types):

\_SB.PCI0.PEGP.EVGA
\_SB.PCI0.PEGP.NVGA
\_SB.PCI0.OVGA

OVGA corresponds to a nonexistent onboard video device (for other
motherboards) and is ignored. EVGA and NVGA don't have addresses
themselves and both correspond to the "PEGP" PCI device which is the MXM
slot on the back of the laptop where the graphics device lives.

All three video devices have the same backlight control hardware because
the EC does that, not the video devices.

The problem here is that video.ko grabs both EVGA and NVGA and makes two
backlight control devices which causes issues when they control the same
hardware.

The patch is supposed to only grab one of the devices under a single PCI
device (in this case it grabs EVGA). This works fine. In my case it
seems that NVGA is the "correct" device (I have an NVidia card, and NVGA
has some MXM-related information too which is referenced from some other
WMI methods elsewhere), but it doesn't matter for video.ko since the
only usable support I can get is backlight adjustment which works the
same way in NVGA and EVGA.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

