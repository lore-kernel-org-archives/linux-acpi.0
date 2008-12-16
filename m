From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Tue, 16 Dec 2008 16:18:13 +0000 (UTC)
Message-ID: <gi8kc5$m5f$6@ger.gmane.org>
References: <gi247o$iog$1@ger.gmane.org> <200812161625.37318.rjw@sisk.pl>
	<gi8jf1$m5f$5@ger.gmane.org> <200812161713.08451.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755913AbYLPQSp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 16 Dec 2008 17:13:08 +0100, Rafael J. Wysocki wrote:
> 
> Hm, this really isn't reasonable.

Many people agree with you.  :-)  There is a long bug open with ubuntu to 
restore this s2ram.  They seem to be ignoring it though.

> s2both saves the image, which takes
> quite a lot of time, while s2ram doesn't.

Indeed.
 
> You can compile s2ram from sources, it's not too difficult.

Yeah.  I will probably just grab the debian package and dpkg-buildpackage 
it on my Ubuntu system.
 
> Hm.  Is that all loaded when you boot with init=/bin/bash (by which I
> mean the minimal config)?

It sure is.  Most assuredly by the initrd.  Debian/Ubuntu systems seem to 
put everything but the kitchen sink into their initrds.  Which on the one 
hand makes them pretty portable and resilient, but on the other, yes, 
bloated.

b.
