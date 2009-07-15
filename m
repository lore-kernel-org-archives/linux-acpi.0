From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [regression] Re: 2.6.31-rc2: thinkpad boots with backlight low
Date: Wed, 15 Jul 2009 11:14:59 -0300
Message-ID: <20090715141459.GA22098@khazad-dum.debian.net>
References: <20090714092513.GB2010@elf.ucw.cz>
 <20090714104712.GB19866@khazad-dum.debian.net>
 <20090715131351.GA2367@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754989AbZGOOPG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090715131351.GA2367@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

On Wed, 15 Jul 2009, Pavel Machek wrote:
> ...and yes, I think it only happens on reboot.

It could be thinkpad-acpi, but it is unlikely.  Lets try one simple test:

1. blacklist thinkpad-acpi so that it doesn't load.

2. boot (without thinkpad-acpi), adjust backlight, then try to reproduce the
problem.  Make sure to test both reboot and shutdown.

That will tell us if it is thinkpad-acpi or not...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
