From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Re: [PATCH v3 1/2] acpi: Add "acpi_osi=" for ASUS X200MA to enable,
 brightness keys
Date: Thu, 18 Dec 2014 17:40:19 +0300
Message-ID: <5492E753.7090505@gmail.com>
References: <5492C5A3.8090700@gmail.com> <CA+5PVA43jLUp4K9=56nwgQJEyLB9EkEynb2PqfEhBWD8q-m-DQ@mail.gmail.com> <5492D938.1020907@gmail.com> <20141218135705.GD4918@srcf.ucam.org> <5492DEE7.8010407@gmail.com> <20141218140930.GA6436@srcf.ucam.org> <5492E32E.2030602@gmail.com> <20141218142629.GA6924@srcf.ucam.org> <5492E5F9.2000504@gmail.com> <20141218143623.GA7335@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20141218143623.GA7335@srcf.ucam.org>
Sender: stable-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

But at least two devices work well with this quirk.
That must be some ASUS UEFI firmware fault, but still it is a workaroun=
d.
You can find some more information in those bugzilla reports.

https://bugzilla.kernel.org/show_bug.cgi?id=3D89401
https://bugzilla.kernel.org/show_bug.cgi?id=3D70241

18.12.2014 17:36, Matthew Garrett =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> That's odd - it looks like the default behaviour in the absence of an=
y
> OSI strings is to just default to an OSYS value that matches Windows
> 2012, so disabling the 2013 value should be equivalent. If it's not,
> it's definitely not safe to turn off all values - there are several
> devices that change behaviour as a result.
>
