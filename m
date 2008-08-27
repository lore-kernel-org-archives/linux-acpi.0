From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to RAM in an Asus P1-AH2
Date: Wed, 27 Aug 2008 22:15:14 +0200
Message-ID: <200808272215.15035.rjw@sisk.pl>
References: <617be8890808270739gdba5c46q6cae8c33668d6bba@mail.gmail.com> <617be8890808270740l4d64c977n17156cf2f7a6dcad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43095 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbYH0ULp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 16:11:45 -0400
In-Reply-To: <617be8890808270740l4d64c977n17156cf2f7a6dcad@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eduard Huguet <eduardhc@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, 27 of August 2008, you wrote:
> Hi,

Hi,

>     I know this is and old topic, but I'd really like to know what's
> the state of the suspend-to-ram feature on this machine. Just to get
> things refreshed, this issue has to deal with the ACPI execution
> ordering, something related to how the different suspend phases are
> ordered differently between ACPI 1.0 and ACPI 2.0.
> 
> Googling around I've seen that there was 2 new kernel parameters,
> acpi_new_pts_ordering and acpi_old_pts_ordering, but I don't know if
> they have been really commited to main kernel trunk. At least, in
> current Gentoo 2.6.25 kernel they are not defined anywhere...
> 
> Anyway, these are the symptoms I'm experiencing whenever I attempt to
> use S3 hibernation: the machine seems to enter a kind of strange
> "frozen" state, in which the CPU fan keeps turning and the power LED
> starts blinking at aproximately 1 Hz. However, the machine is really a
> dead-stone yet, and the only way to get it back is powering it off by
> holding down power button for 4s and then restarting.
> 
> This happens both when using 'hibernate-ram' script or new 's2ram' program.

Please try the latest kernel (2.6.27-rc4-git) with 'acpi_sleep=old_ordering' in
the command line.

Thanks,
Rafael
