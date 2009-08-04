From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan-caicS1wCkhO6A22drWdTBw@public.gmane.org>
Subject: Re: [Bug #13471] Loading parport_pc kills the keyboard if ACPI is
 enabled
Date: Tue, 04 Aug 2009 14:33:02 +0300
Message-ID: <4A781C6E.7040900@pardus.org.tr>
References: <DizPU9GBfHF.A.kgF.iWObKB@chimera>	<H5-1lZIIeYK.A.dWH.9XObKB@chimera>	<20090731151417.568094e5@lxorguk.ukuu.org.uk>	<4A7308E8.1000200@pardus.org.tr> <20090731161735.6a94ad9c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090731161735.6a94ad9c-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Alan Cox wrote On 31-07-2009 18:17:
> There have been few changes to parport_pc but one thing recent changed
> the probe for SuperIO chips via low addresses and that could be
> interfering.
>
> commit e2434dc1c19412639dd047a4d4eff8ed0e5d0d50
> Author: Jens Rottmann <JRottmann-pZAVvlj+WpoXz/+GnIZSFIQuADTiUCJX@public.gmane.org>
> Date:   Mon Jun 22 16:51:49 2009 +0100
>
> changed the behaviour slightly (hence asking about which release if it
> was a recent breakage). Its also a code area with very few changes so if
> you can find which one worked last, you should be able to transplant that
> parport_pc into 2.6.current and see if its parport or acpi triggered
> breakage.
>   

I've tested on 2.6.30.4 which has apparently this commit, no changes.

I've booted into Ubuntu 8.10 which has 2.6.28. The keyboard was working
correctly eventhough parport_pc was loaded. I removed and re-probed and
the keyboard is gone.

I've set BIOS settings to default, nope.

I'll try bisecting when I find the last-good/first-bad kernel version.
