From: Luke Sharkey <lukesharkey@hotmail.co.uk>
Subject: acpi thermal sensors not working, laptop overheating
Date: Fri, 13 Jun 2008 12:07:45 +0100
Message-ID: <BAY114-W23E452D9A025AF7E6A5225FAAC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc3-s16.bay0.hotmail.com ([65.54.246.216]:60759 "EHLO
	bay0-omc3-s16.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752244AbYFMLNz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jun 2008 07:13:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi

I've been having problems with thermal regulation on my laptop.  Having=
 skimmed through a few past posts I appreciate that this is a pretty hi=
gh level mailing list so if I make repeated displays of my ignorance (o=
r if I'm on the wrong list altogether) please forgive me.

--PREAMBLE--
I have a hp pavilion dv5000 series laptop with an AMD turion 64 "ML-32"=
 processor (64 bit) on which I am running ubuntu 8.04.  I have only rec=
ently replaced my hard drive *after only two years* when it failed.  I =
transcoded a large number of dvds in the first month after purchase, an=
d experienced weird problems due to overheating - Win XP / linux wouldn=
't boot / with lots of errors, colourled lines appeared down the side o=
f my screen, linux installations ever since then started corrupting eve=
ry few months, finally my hard drive failed...

I think this may be because of heat damage?  I had had both lm-sensors =
and hddtemp installed before, but I never really knew what the output v=
alues meant, until when I got the new hdd I randomly installed the gnom=
e panel sensors applet, and got a bit worried by the red bars and repea=
ted warning messages.


--PROBLEM--
Hddtemp seems normal - 20C when I first switch on, levels out at 40C af=
ter an hour or two.
However, after 20mins or so lm-sensors reports a gradual climb in Core0=
 temperature, which is recieving input from k8temp module, which I read=
 on their freshmeat page records the SOCKET / ON-DIE temperature.  Some=
body told me that this refers to the temperature of the outside housing=
 of the CPU, and that therefore the actual CPU temp is much higher!!

Example sensors output:
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +54.0=B0C                                   =20

Unfortunately I am getting no recording of the internal core temperatur=
e - which I am worried must be far too high! I am very concerned about =
this - on a limited budget relatively I found the new hdd expensive to =
my means.

When I do this command I get the following:
cat /proc/acpi/thermal_zone/THRM/*=20



state:                   ok
temperature:             0 C
critical (S5):           94 C
passive:                 90 C: tc1=3D2 tc2=3D5 tsp=3D50 devices=3DCPU0=20




state:                   ok
temperature:             0 C
critical (S5):           94 C
passive:                 90 C: tc1=3D2 tc2=3D5 tsp=3D50 devices=3DCPU0=20

=46rom the Core0 / on-die temp I am worried that my CPU temp might be v=
ery high, but for some reason it is not being recorded?!?  (Why is a st=
ate of 0C considered "ok"?  Surely this should trigger an error message=
 that *clearly* the temperature sensor must not be working?)

My fan is working, I hear it occasionally when the temperature spikes, =
but it must be set in the bios to not be active enough - again, on-die =
/ core0 temp is 55C - very hot! - and the fan is hardly on at all!  The=
 phoenix bios is rubbish - there are hardly any settings to be changed =
at all.  When I try running e.g. a 3D game, the core0 / on-die temp can=
 rise to above 70C...!!!  As a temporary measure I have set my cpu freq=
uency governor to powersave, which generally keeps core0 to below 60C.

I also read somewhere that the fan can be manually controlled by passin=
g values to files in /proc/acpi/fan , but unfortunately this folder is =
completely empty.
With regards to the fan I was informed that it might need cleaning, and=
 I intend to do this.  However, this can't be the sole cause of the pro=
blem as I've been having temperature problems with this laptop since th=
e day I bought it (see preamble above).  If it was only the fan getting=
 clogged, then logically it would have been a progressive problem as th=
e fan became dirtier...

Why is acpi not recording my cpu temperature?  How can I get my fans to=
 be more proactive and so avoid wrecking my hardware a second time?  Th=
anks

My kernel version is 2.6.24-18-generic (64 bit).  What I've written is =
basically the limits of my knowledge, and I'm no linux guru, so if I've=
 omitted anything my apologies


Cheers,
Luke S

end

_________________________________________________________________

All new Live Search at Live.com

http://clk.atdmt.com/UKM/go/msnnkmgl0010000006ukm/direct/01/--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
