From: Norbert Preining <preining@logic.at>
Subject: Re: regression since 2.6.36: backlight in sony-laptop not working
Date: Wed, 17 Nov 2010 15:33:38 +0900
Message-ID: <20101117063338.GG29129@gamma.logic.tuwien.ac.at>
References: <20101104142915.GC7650@gamma.logic.tuwien.ac.at> <20101110035833.GB3029@kamineko.org> <20101111235000.GA6651@gamma.logic.tuwien.ac.at> <20101112034423.GA7407@srcf.ucam.org> <20101112035027.GD26742@gamma.logic.tuwien.ac.at> <20101112035732.GB7574@srcf.ucam.org> <20101112042243.GE2852@kamineko.org> <20101117063006.GF29129@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:44368 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933323Ab0KQGdn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Nov 2010 01:33:43 -0500
Content-Disposition: inline
In-Reply-To: <20101117063006.GF29129@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

> - recompiled a input-kbd binary with a relaxed version check
> 	-	if (EV_VERSION != version) {
> 	+	if (EV_VERSION > version) {
>   in input.c, line 104 of input-utils.

Furthermore, although both of you referred to the fact that udev keymap
is working, I checked that Debian/sid uses udev kbd rules, but it 
stopped working ...

Best wishes

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
There are of course many problems connected with life, of
which some of the most popular are `Why are people born?'
Why do they spend so much of the
intervening time wearing digital watches?'
                 --- The Book.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
