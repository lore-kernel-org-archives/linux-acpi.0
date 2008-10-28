From: Mattia Dongili <malattia@linux.it>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Tue, 28 Oct 2008 10:41:48 +0900
Message-ID: <20081028014148.GB28057@inferi.kami.home>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <Pine.LNX.4.63.0810251854180.10973@dashnine.joshuawise.com> <20081025233118.GA31722@gandalf.dynalias.org> <20081027232051.GI22083@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:32780
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750846AbYJ1BmA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Oct 2008 21:42:00 -0400
Content-Disposition: inline
In-Reply-To: <20081027232051.GI22083@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Joshua Wise <joshua@joshuawise.com>, drzeus-mmc@drzeus.cx, linux-acpi@vger.kernel.org

On Tue, Oct 28, 2008 at 12:20:51AM +0100, Norbert Preining wrote:
> Hi Joshua, hi all,
...
> > > That works only if in Intel mode; use smartdimmer in nVidia mode.
> > 
> > I never got it working, and I am always running in intel = stamina mode.
> > Nothing whatever I do changes the brightness of the screen. Neither
> > using 
> > 	/sys/devices/virtual/backlight/sony/brightness
> > nor 
> > 	/sys/devices/virtual/backlight/acpi_video0/brightness
> 
> Running in Intel mode, no changes what-so-ever in brightness.
> 
> Mattia, are you listening? Do you have any idea what might go wrong
> here?

Yes, I am. But I have no idea what might be wrong. Did you also try
xbacklight while in X and using the Intel card?

-- 
mattia
:wq!
