From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 22:03:00 +0000
Message-ID: <20060420220300.GD2352@ucw.cz>
References: <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com> <20060420164419.GA30317@srcf.ucam.org> <4447BB2B.1060407@linux.intel.com> <20060420165515.GA30415@srcf.ucam.org> <4447BF98.4020806@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27911 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751006AbWDVTU6
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Apr 2006 15:20:58 -0400
Content-Disposition: inline
In-Reply-To: <4447BF98.4020806@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Xavier Bestel <xavier.bestel@free.fr>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 20-04-06 21:06:32, Alexey Starikovskiy wrote:
> Matthew Garrett wrote:
> >On Thu, Apr 20, 2006 at 08:47:39PM +0400, Alexey 
> >Starikovskiy wrote:
> >
> >>Yes, this is why I mentioned using kevent and dbus 
> >>before... Could it be the righter answer?
> >
> >I think it makes sense for atkbd and usb hid power and 
> >sleep buttons to be treated like all other keys on those 
> >keyboard types. As a result, I think it makes sense for 
> >ACPI keys to behave in the same way. I wrote an addon 
> >for hal to take input events and put them on the system 
> >dbus some time ago, so that's already a solved problem.
> >
> So now you can do a shortcut and send ACPI events to dbus 
> without involving input layer and hal.

And break handheld devices and require everyone to run dbus?

							Pavel
-- 
Thanks, Sharp!
