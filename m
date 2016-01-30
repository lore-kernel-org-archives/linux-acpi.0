From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ibm-acpi developers not responding despite serious bugs and
 debuggers
Date: Sat, 30 Jan 2016 13:56:14 -0200
Message-ID: <20160130155614.GB14919@khazad-dum.debian.net>
References: <CAJXMp+ozoeeca_WMKfDOKhbLuf1hE_-m-Cv2KhsztYVZ-OEYLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39440 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756917AbcA3P4T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Jan 2016 10:56:19 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8F2F0297F7
	for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2016 10:56:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAJXMp+ozoeeca_WMKfDOKhbLuf1hE_-m-Cv2KhsztYVZ-OEYLA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jono <lejono@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net

On Sat, 30 Jan 2016, jono wrote:
> Sorry to trouble you, but a number of us are having lots of grief
> getting a response from ibm/lenovo regarding acpi bugs in newer models
> like the Helix 2. The bugs make these machines difficult to use, and
> there are various reports of this on the internet, along with people
> willing to debug patches. But it's impossible to contact anyone on the
> ibm-acpi team to help with this. Do you know who we can contact to

There's me for ibm-acpi-devel, but let's make one thing VERY clear:

1.  I do not work for Lenovo or IBM, I never did.  I am a volunteer.

2.  That specific ML is about the thinkpad-acpi driver, not about anything
    else, not even generic ACPI issues.

Also, I work on thinkpad-acpi on my spare time, I do not have the hardware
to test many of the issues in the first place as I get no help at all from
Lenovo Brazil, so my resources to help are often very limited.

> The example is the Helix 2, see:
> https://bugzilla.kernel.org/show_bug.cgi?id=100171

This is not a thinkpad-acpi bug as far as I can see, but thinkpad-acpi is a
completely optional driver: anytime you suspect it of something, you just
remove it, reboot, and check if things start working.  If they do, you can
contact me about it and we will find the root cause and fix it.

On a related note, for a while you *could* unofficially reach some Lenovo
people through the linux-thinkpad ML.  You'd comment on something there --
with **all** the relevant detais as you often would get only one shot at
getting their attention, so you must make it count! -- and after a while,
Lenovo would (often silently) act on it.  I am unsure if they are still
lurking there, but you could try.

That said, please ensure you're running the latest Lenovo firmware on *any*
ThinkPad that is experiencing issues, and install your distro's distribution
for the Intel processor package unified update (aka "Intel microcode update"
-- it was reported that nowadays it updates more areas of the chip, such as
power management control/tables, etc.).

> and various repetitions of this...
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1424088
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1520965?comments=all

Same deal as bugzilla #100171, above.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
