From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V5 1/2] introduce ALS sysfs class
Date: Mon, 31 Aug 2009 16:48:57 +0800
Message-ID: <1251708537.3483.191.camel@rzhang-dt>
References: <1251706028.3483.160.camel@rzhang-dt>
	 <20090831083449.GB11117@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753195AbZHaIvF@vger.kernel.org>
In-Reply-To: <20090831083449.GB11117@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2009-08-31 at 16:34 +0800, Pavel Machek wrote:
> Hi!
> 
> > @@ -0,0 +1,32 @@
> > +What:		/sys/class/als/als[0-N]/desc
> > +Date:		Aug. 2009
> > +KernelVersion:	2.6.32
> > +Contact:	Zhang Rui <rui.zhang@intel.com>
> > +Description:	Strings which descibes the current Ambient Light Sensor
> > +		device. This is given by native ALS driver as part of
> > +		registration. e.g: "acpi_als" for ACPI ALS devices.
> > +		RO
> 
> Normal way to do that (backlight class does it, for example) is to
> have acpi_als instead of als0, and get rid of desc field.

IMO, both are okay, hard to say which is preferred.
Other sysfs classes like scsi_host, hwmon, input use this as well.
and you don't have a really strong objection to this, right? :)

thanks,
rui
