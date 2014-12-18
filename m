From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Re: [PATCH v3 1/2] acpi: Add "acpi_osi=" for ASUS X200MA to enable,
 brightness keys
Date: Thu, 18 Dec 2014 21:20:03 +0300
Message-ID: <54931AD3.1050305@gmail.com>
References: <5492D938.1020907@gmail.com>	<20141218135705.GD4918@srcf.ucam.org>	<5492DEE7.8010407@gmail.com>	<20141218140930.GA6436@srcf.ucam.org>	<5492E32E.2030602@gmail.com>	<20141218142629.GA6924@srcf.ucam.org>	<5492E5F9.2000504@gmail.com>	<20141218143623.GA7335@srcf.ucam.org>	<5492E753.7090505@gmail.com>	<20141218144337.GA7613@srcf.ucam.org>	<20141218145054.GA7745@srcf.ucam.org> <CAJvTdKnejv9cKPW9sbnLswfBsWZCA1OU2os7iud9tKoq7CW+jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdKnejv9cKPW9sbnLswfBsWZCA1OU2os7iud9tKoq7CW+jw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

Len,

I completely agree that debugging and testing of a real solution would =
be a problem.
And adding "acpi_osi=3D" is not too hard as a boot option.

In some cases it can be built-in, if it is a box solution.

So the patch is no good.

18.12.2014 21:09, Len Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> NAK on addoing this acpi_osi=3D quirk to upstream Linux.
>
> The reason is that problem is being actively debugged.
> Quirks in upstream Linux are for when we give up.
>
> Sure, it is perfectly okay for individual users to invoke it.
> It is even fine for a distro to check in this workaround if they care
> about that box working *now*
> and they are not concerned about side effects.
>
> But the real fix is in development, and checking workarounds with
> possible other side-effects
> into up-stream Linux is just a distraction from getting it right for
> not just this machine,
> but other machines w/ the same issue.
>
> thanks,
> Len Brown, Intel Open Source Technology Center
>
> ps. lots of people are mis-using acpi_osi=3D in debugging, please con=
sult
> Documentation/kernel-parameters.txt for a detailed description of how
> this cmdline option works.  Note, in particular, that acpi_osi=3DXYZ =
by itself
> will _add_ XYZ to the list of recognized strings.  If that string is
> already built
> into Linux (eg. "Windows 2012"), then adding it again has no effect.
>
