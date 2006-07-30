From: Greg KH <greg@kroah.com>
Subject: Re: Generic battery interface
Date: Sun, 30 Jul 2006 02:00:59 -0700
Message-ID: <20060730090059.GC17759@kroah.com>
References: <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com> <20060729103613.GB7438@suse.cz> <41840b750607290432m6d302cdoae7f3eef869279d4@mail.gmail.com> <20060729120411.GA8285@suse.cz> <41840b750607290551kae4a7c7k9402c96e5b67e6a5@mail.gmail.com> <20060729134225.GA4882@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48555 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932076AbWG3JFR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 05:05:17 -0400
Content-Disposition: inline
In-Reply-To: <20060729134225.GA4882@suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>

On Sat, Jul 29, 2006 at 03:42:25PM +0200, Vojtech Pavlik wrote:
> On Sat, Jul 29, 2006 at 03:51:45PM +0300, Shem Multinymous wrote:
> > Given the current usage pattern of sysfs, is it still a bad idea for
> > it to carry device inodes?
>  
> That remains an open question.

No, that's a closed question.  It simply will not happen.  Linus vetoed
this years ago, for lots of different reasons that I can't recall at the
moment (namespaces, permissions, groups, and other things from what I
remember.)

Search the lkml archives if you are really curious...

thanks,

greg k-h
