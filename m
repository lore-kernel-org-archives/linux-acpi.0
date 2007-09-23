From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.23-rc7] main.c: undefined reference to `acpi_sleep_prepare'
Date: Sun, 23 Sep 2007 15:35:09 +0200
Message-ID: <200709231535.09759.rjw@sisk.pl>
References: <200709230152.31120.elendil@planet.nl> <46F60AA2.1060500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48223 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbXIWNVk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 09:21:40 -0400
In-Reply-To: <46F60AA2.1060500@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sunday, 23 September 2007 08:41, Alexey Starikovskiy wrote:
> Frans Pop wrote:
> > I wanted to test 5a50fe709d527f31 and thus created a config with ACPI and 
> > CONFIG_HIBERNATION, but without CONFIG_SUSPEND, which resulted in (git 
> > checkout updated to 1f0cff6e4d579ab0):
> > 
> >   GEN     .version
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o: In function `acpi_power_off_prepare':
> > main.c:(.text+0x32282): undefined reference to `acpi_sleep_prepare'
> > drivers/built-in.o: In function `acpi_hibernation_prepare':
> > main.c:(.text+0x3228c): undefined reference to `acpi_sleep_prepare'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > make[1]: Leaving directory `/home/fjp/projects/kernel/linux-2.6'
> > make: *** [debian/stamp-build-kernel] Error 2
> > 
> > 
> yep... acpi_sleep_prepare was put under CONFIG_SUSPEND spanning half of the file...
> this patch moves it out.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
