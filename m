From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] acpi: add backlight support to the sony_acpi driver (v2)
Date: Wed, 6 Dec 2006 15:25:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0612061525140.28745@pentafluge.infradead.org>
References: <20061127174328.30e8856e.alessandro.guido@gmail.com>
 <20061201133520.GC4239@ucw.cz> <20061201194337.GA7773@khazad-dum.debian.net>
 <20061202162352.GD4773@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933835AbWLFP0F@vger.kernel.org>
In-Reply-To: <20061202162352.GD4773@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org


Its nice to see acpi moving to the backlight api. Will acpi also move to 
hwmon and led class support ?

On Sat, 2 Dec 2006, Pavel Machek wrote:

> Hi!
> 
> > > Looks okay to me. We really want unified interface for backlight.
> > 
> > Then I request some help to get
> > http://article.gmane.org/gmane.linux.acpi.devel/19792
> > merged.
> > 
> > Without it, the backlight interface becomes annoying on laptops.  Your
> > screen will be powered off when you remove the modules providing the
> > backlight interface.  This is not consistent with the needs of laptop
> > backlight devices, or with the behaviour the drivers had before the
> > backlight sysfs support was added.
> 
> Just retransmit it to akpm and list, and add acked-by headers with
> people who said patch is okay... that included me IIRC.
> 
> 
