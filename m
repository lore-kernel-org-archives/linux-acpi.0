From: Len Brown <lenb@kernel.org>
Subject: Re: active[0] being ignored
Date: Fri, 23 Mar 2007 12:06:13 -0400
Message-ID: <200703231206.13236.lenb@kernel.org>
References: <46018B9A.7060106@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38397 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992480AbXCWQHd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Mar 2007 12:07:33 -0400
In-Reply-To: <46018B9A.7060106@web.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mirco Jeske <m.jeske@web.de>
Cc: linux-acpi@vger.kernel.org

On Wednesday 21 March 2007 15:46, you wrote:
> Hi all,
> I have an asus A3G with opensuse 10.2 running. My trip points are
> 
> critical (S5):           99 C
> passive:                 60 C: tc1=2 tc2=10 tsp=100 devices=0xdffec504
> active[0]:               75 C: devices=0xdffe157c
> 
> I do not have an active[1] point. My cooling_mode is active. Therefore I
> would expect the fan to start cooling as soon as the temperature
> reaches  the 75C mark. Instead, the fan runs even if the temperature is
> like 45C. Sometimes the fan goes on and off several times within a short
> period of time so it starts to be annoying.
> 
> Is there a way to force the fan to only run at 75C?

Probably not.

Every system is different in this area, and some of them
simply over-ride the trip points you set,
but the picture above shows that passive throttling is
supposed to kick in at 60C, and  the active fan at 75C.

75C is pretty hot.  It is possible that there are other
fan controls -- perhaps lower speeds -- done by microcontroller
before  you hit this level, and the device at 75C may refer to top speed.

See if you can have any effect on this at all

echo 99:98:75:40 > trip_points

and in theory, if temperature is above 40, the fan should turn on.
If it does, then look at trip_points and see if the BIOS overwrites them.

As the fan is doing things below the 75C above already, I predict
that you have little control over it with these methods.
If you really want to dig into it, you'll need to dis-assemble your DSDT
to see what the AML for this box does with temperature events --
but your description above suggests that will not show you the whole
picture.  See also if there are any options in BIOS setup related
to active and passive cooling.

cheers,
-Len
