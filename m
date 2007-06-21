From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ACPI Regression on Dell E1501
Date: Thu, 21 Jun 2007 23:55:02 +0200
Message-ID: <1182462902.3316.105.camel@chaos>
References: <467AE7E1.4050805@canonical.com>  <467AF204.3060805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:33376 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757362AbXFUVzF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 17:55:05 -0400
In-Reply-To: <467AF204.3060805@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Tim Gardner <tim.gardner@canonical.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2007-06-21 at 17:47 -0400, Chuck Ebbert wrote:
> On 06/21/2007 05:04 PM, Tim Gardner wrote:
> > Hi,
> > 
> > Commit e9e2cdb412412326c4827fc78ba27f410d837e6e breaks boot on a Dell
> > E1501 unless 'acpi=off' is specified (also tried nolapic and nohpet but
> > it made no substantive difference). This laptop is an 'AMD Turion(tm) 64
> > X2 Mobile Technology TL-50' CPU, but its booting 32 bit SMP (make
> > defconfig). No kernel built after this commit works for this platform.
> > 
> > There is no crash output, it just wedges after 'NET: Registered protocol
> > family 2'.
> > 
> > How can I debug this problem?
> 
> That'll be fun.
> 
> That's:
> 
> 	[PATCH] clockevents: i386 drivers
> 
> [Author cc: added]

I'm going nuts on this. 

Tim, 

1.) are you booting a 32bit or a 64 bit kernel ?

2.) Can you please try 2.6.22-rc5 + 
http://www.tglx.de/projects/hrtimers/2.6.22-rc5/patch-2.6.22-rc5-hrt1.patch
	whether this makes any difference 

Thanks,

	tglx




