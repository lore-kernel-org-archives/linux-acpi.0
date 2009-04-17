From: Hannu Vuolasaho <vuokko@nukku.net>
Subject: Re: How to use fujitsu-laptop for keyboard lights?
Date: Fri, 17 Apr 2009 18:05:01 +0300 (EEST)
Message-ID: <Pine.LNX.4.53.0904171631230.32703@hyvin.nukku.net>
References: <Pine.LNX.4.53.0904161333241.32703@hyvin.nukku.net>
 <20090416133059.6cc1adce@linx.net> <Pine.LNX.4.53.0904170329110.32703@hyvin.nukku.net>
 <20090417133004.0e087bdf@linx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from x.venko.net ([212.246.29.154]:45063 "HELO nukku.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755890AbZDQPFG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Apr 2009 11:05:06 -0400
In-Reply-To: <20090417133004.0e087bdf@linx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: linux-acpi@vger.kernel.org



On Fri, 17 Apr 2009, Tony Vroon wrote:

> Provided you load it in the right order, yes. The led class will need
> to be loaded *before* fujitsu-laptop.

No. That's not working. Since I first tried option index=2 as in alsa
drivers to put /etc/modprobe.conf which make fujitsu-laptop to fail and
after that I edited  modprobe.conf again and loaded fujitsu-laptop. Result
was no kblamps anywhere.

Also led_class wasn't used by fujitsu-laptop. Second try was put in
/etc/rc.conf MODULES=(led_class fujitsu_laptop) same thing. No kblamps
anywhere.

I even blacklisted fujitsu-laptop and manually loaded it and even then
lights didn't work. seems that I can't get fujitsu-laptop to work with
led-class module.

Stupid to ask but because led-class is used with ath5k and sdhci, can
fujitsu-laptop still register its led? I believe it would be stupid if I
couldn't plug my led blinker USB-dongle and get led device for it.

>
> > Now I have /sys/devices/platform/leds/fujitsu\:\:kblamps/brightness
> > which doesn't bring the lights on when I say echo 255 or anything
> > else. I try to do it wrong I believe.
>
> It is odd that you get duplicate LED devices. It does appear to be a
> phantom device.
>
> > Instead I can get them on saying
> > echo 255>/sys/class/leds/fujitsu\:\:kblamps/brightness.
>
> Especially as that one works.

Well not any more. I wondered why I was'n able to put lights on. It
appears that echo 255 > works echo 255>doesn't. So I knew it I was doing
it wrong :) Both devices work. They are just duplicates.

> So you get no log entries for the "wrong" platform device, but you do
> get entries for the second, working device? (It wouldn't make sense to
> me if the LED state changes without log entries being made, as it takes
> a FUNC callback to do it)

Now they both work and create log entries as I know how to say echo :)
I propably messed with my echo dmesg echo commands. Sorry. I'm not
perfect.

Is it possible to put kblamp in heartbeat mode? Kind of cool idea if
lights would go off-> HB-> on ->HB -> off by pressing / quickkey

>
> > And this machine is F-S biblo loox u50x/v Small Japanese netbook. (My
> > first portable computer. Fits in pocket.)
>
> The DSDT looks good, the keyboard LED is presented as the driver
> expects. Seems very similar to the U810.

Yes. instead of having webcam I have Japanese digital TV receiver and
weird keyboard.

Hannu Vuolasaho
