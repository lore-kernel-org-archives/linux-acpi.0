From: Norbert Preining <preining@logic.at>
Subject: Re: sony-laptop on VAIO TT help request
Date: Fri, 1 Jul 2011 18:50:49 +0900
Message-ID: <20110701095049.GE11959@gamma.logic.tuwien.ac.at>
References: <4E0C4AE2.2050706@fnarfbargle.com> <20110630135507.GA24186@kamineko.org> <4E0C9BC6.4020603@fnarfbargle.com> <4E0D9765.7060700@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E0D9765.7060700@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Brad Campbell <lists2009@fnarfbargle.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marco,

On Fr, 01 Jul 2011, Marco Chiappero wrote:
>>> http://www.absence.it/vaio-acpi/source/patches/
>
> could you please provide us your DSDT and the exact model string of your TT?

I looked a bit through the patch and I see that it is restricted
to MM and (forgotten the model number). I have a VGN-Z11 which has
also a turn on/off optical drive, a shock sensor etc.

I would be interested in trying out some of these new things and see if
they can work in the Z11, too.

(btw, I also take care for the sony-laptop-zseries variant of the
kernel module where you can turn off and on the nvidia card,
and also the led of the speed-stamina switch is controlled. After
I have tried your patches I will try to merge my patches back into
yours.)

Best wishes

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
OK, so ten out of ten for style, but minus several million
for good thinking, yeah?
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
