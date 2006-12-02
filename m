From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] acpi: add backlight support to the sony_acpi driver (v2)
Date: Sat, 2 Dec 2006 16:23:52 +0000
Message-ID: <20061202162352.GD4773@ucw.cz>
References: <20061127174328.30e8856e.alessandro.guido@gmail.com> <20061201133520.GC4239@ucw.cz> <20061201194337.GA7773@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1424120AbWLBQil@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061201194337.GA7773@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Looks okay to me. We really want unified interface for backlight.
> 
> Then I request some help to get
> http://article.gmane.org/gmane.linux.acpi.devel/19792
> merged.
> 
> Without it, the backlight interface becomes annoying on laptops.  Your
> screen will be powered off when you remove the modules providing the
> backlight interface.  This is not consistent with the needs of laptop
> backlight devices, or with the behaviour the drivers had before the
> backlight sysfs support was added.

Just retransmit it to akpm and list, and add acked-by headers with
people who said patch is okay... that included me IIRC.

-- 
Thanks for all the (sleeping) penguins.
