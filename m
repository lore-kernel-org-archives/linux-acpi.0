From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: /proc/acpi/ removal plan
Date: Thu, 18 Sep 2008 23:43:43 -0400
Message-ID: <20080919034343.GA7594@core.corenet.prv>
References: <200809181633.m8IGX1s7019188@hera.kernel.org> <7C8E86B73C916D47820B1A143DB97BC00887719AEE@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:61783 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140AbYISDnv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Sep 2008 23:43:51 -0400
Received: by rn-out-0910.google.com with SMTP id k40so88890rnd.17
        for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2008 20:43:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7C8E86B73C916D47820B1A143DB97BC00887719AEE@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@hera.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>

On Fri, Sep 19, 2008 at 10:12:25AM +0800, Zhang, Rui wrote:
> >
> >>  button sys I/F can be found at /sys/class/input/.
> >> e.g.
> >> # cat /sys/class/input/input*/device/hid
> >> LNXPWRBN
> >> PNP0C0C
> >
> >The /proc files for power and sleep buttons simply
> >told us what kind of button they were, just info, not API.
> >
> >The functional one is PNP0C0D, the lid switch.
> >It is also reflected in /sys/class/input, but I don't
> >see a way to find from /sys the open/closed state
> >like we have in /proc.  (I ran into this when I tried
> >to delete the button /proc I/F some time ago).
> >
> You're right. Lid device still needs such an I/F.
> 

Input devices do not export their state through sysfs (1 file per
every possible event would mean 100s of files per keyboard) but writing
an tiny utility to get thos information through /dev/input/event for
use by scripts should be trivial.

-- 
Dmitry

