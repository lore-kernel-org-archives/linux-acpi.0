From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to RAM in an Asus P1-AH2
Date: Tue, 2 Sep 2008 21:17:01 +0200
Message-ID: <200809022117.02404.rjw@sisk.pl>
References: <617be8890808270739gdba5c46q6cae8c33668d6bba@mail.gmail.com> <200809021903.24026.rjw@sisk.pl> <617be8890809021058y37c032a2t9e48f113e2b3f1bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43282 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbYIBTNO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2008 15:13:14 -0400
In-Reply-To: <617be8890809021058y37c032a2t9e48f113e2b3f1bd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eduard Huguet <eduardhc@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday, 2 of September 2008, Eduard Huguet wrote:
> Hi,
>     Sorry, I misread the previous email. This time I checked the
> CONFIG_FTRACE option and redone the tests, so anyway that's good
> because I'm sure that in my previous test it was unset.
> 
> About how I am suspending to ram, I'm currently using Gentoo
> 'hibernate-ram' script, which in turn is using s2ram. The options
> passed to the s2ram are "-f -s -a 3" if I remember correctly (can't
> check the logs right now). The hibernate-ram script does some stuff
> before suspending, like unloading some modules, etc...
> 
> Also, as I'm doing some very basic testing only, before attempting to
> suspend I issue a 'init 1' command so I go into single-user mode, no
> X. In some cases I even unload nvidia.ko module by using rmmod, but
> I'm pretty sure this don't make any difference.

Is there any difference if you do just  'echo mem > /sys/power/state' instead
of running s2ram?

Did you try to run s2ram manually (ie. without the script from Gentoo)?

Did you try any other combinations of s2ram options?

Thanks,
Rafael
