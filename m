From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Tue, 31 Jul 2012 12:29:43 +0200
Message-ID: <CAKPcRGq+nRdttN=fj0E6jU+53+m7s0oJaB_kaZhV3=-9Dm199A@mail.gmail.com>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
	<1631921.mapqS8Vd5c@pali>
	<1332303391.10557.391.camel@linux-s257.site>
	<7304456.Po7HTnWu9F@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <7304456.Po7HTnWu9F@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: joeyli <jlee@suse.com>, linux-acpi@vger.kernel.org, Artur Flinta <aflinta@gmail.com>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 28, 2012 at 4:47 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> Hello, I have some good news. Radeon patches from this post
> http://lists.freedesktop.org/archives/dri-devel/2012-July/025535.html
> export brightness file /sys/class/backlight/radeon_bl/brightness
> And finally with these patches I'm able to change brightness on my El=
iteBook.

Nice, in your older mail I read:

> The PEGP.DGFX acpi device was binding to
> acpi/video driver, the above ASL code emit a 0xD0 bus event to
> video.c but cann't process it. Even we add a new bus event in
> video.c and generate a acpi event, there still need another acpi
> driver should take care it.

That event (0xd0) is probably a custom event announced through ATIF.
I'm working on the code to deal with it, the latest patches are here:

http://lists.freedesktop.org/archives/dri-devel/2012-July/025646.html

You first need this one with the ACPI header:
http://lists.freedesktop.org/archives/dri-devel/2012-July/025517.html

and the other 3 that you've already tested. With my patches on top you
should be able to change the brightness using the hotkeys.

I'd be grateful if you could test them :-)

Luca
