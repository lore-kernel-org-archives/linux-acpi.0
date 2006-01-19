From: Minty <mintywalker@gmail.com>
Subject: acpi on the sony tx1xp vaio laptop
Date: Thu, 19 Jan 2006 01:17:09 +0000
Message-ID: <e1868cfe0601181717m47dbb220l92d2b70033ca4655@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.195]:56156 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161139AbWASBRK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 20:17:10 -0500
Received: by uproxy.gmail.com with SMTP id s2so40557uge
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 17:17:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hello,

I've got a Sony TX1XP laptop running Kubuntu [1].

There are a couple of acpi things that I'd love to be improved on this
machine, so I'm offering to help out if I can - but I could use some
direction from someone who has a clue about acpi and it's workings. 
I'm happy enough (although not that great at) kernel compiling if need
be.  Fwiw, I know of two others running some linux variant on this
machine/hardware.

Main issue:
/proc/acpi/fan exists, but is empty.
Fan comes on for about 20 sec, off for 5 secs, repeat.
Regardless of cpu temp.

cpu temp is accurately reported, normally sitting at 61C, but I've
seen it go higher when the machine is under load.  thermal_zone
reports passive cooling, but aside from reporting the temp, anything
that might be set is reported as "<setting not supported>".  It
appears that cpu throttling works via
/proc/acpi/processor/CPU0/throttling but this doesn't appear to alter
the behaviour of the fan.

Ideally, I would like to gain ability to control fan.  Being on all
the time would be preferable to the constant on/off/on/off loop it is
currently in.  That said, my belief is that it is currently a little
over eager and could probably stay off for longer periods when the
machine is not loaded without causing any overheating.

There is nothing in the bios about fan/temp settings/controls.

By the by, I can suspend to RAM (although it takes between 60 and 120
seconds to resume from that state), but suspend to disk is entirely
broken.  I am assuming a switch to suspend2 should help there, which
I'm hoping Kubuntu are going to adopt in a later release.  Although
any pointers would be most welcome.

Pointers welcome.

[1] http://tinyurl.com/d8fjs
