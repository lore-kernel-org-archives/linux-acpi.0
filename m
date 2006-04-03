From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: slow susped to disk
Date: Mon, 3 Apr 2006 11:50:49 +0200
Message-ID: <200604031150.49781.rjw@sisk.pl>
References: <4430E44B.7070003@triumf.ca> <200604031128.02974.rjw@sisk.pl> <20060403094716.GC12475@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37611 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751710AbWDCJwD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2006 05:52:03 -0400
In-Reply-To: <20060403094716.GC12475@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zaher Salman <zaher@triumf.ca>, linux-acpi@vger.kernel.org

Hi,

On Monday 03 April 2006 11:47, Pavel Machek wrote:
> > > I upgraded the kernel from 2.6.15 to 2.6.16 on my presario 2100. Both 
> > > kernels were compiled with the similar configuration files. Anyway I 
> > > found that suspend to disk (and resume) is much slower on 2.6.16 
> > > compared to 2.6.15. Any idea for why that might happen or how can I 
> > > speed it up? There is also a big difference when suspending with the 
> > > laptop plugged or not..
> > 
> > This is because the size of the suspend image is now greater than
> > for 2.6.15.
> > 
> > There's the /sys/power/image_size knob that controls the size of the image.
> > If you set it to 0 (eg. by echo 0 > /sys/power/image_size as root), the
> > 2.6.15 behavior should be restored.  However, if you set image_size > 0
> > it should improve the system responsiveness after resume.
> > 
> > Please refer to Documentation/power/interface.txt in the kernel tree for
> > details.
> 
> If you don't mind, I have added it to the FAQ.

ACK

Rafael
