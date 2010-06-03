From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: Fix the incorrect calculation about C-state idle
	time
Date: Thu, 03 Jun 2010 09:06:54 +0800
Message-ID: <1275527214.3718.38.camel@localhost.localdomain>
References: <1275447849-25761-1-git-send-email-yakui.zhao@intel.com>
	 <20100602150659.GA5335@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28445 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757873Ab0FCBJy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Jun 2010 21:09:54 -0400
In-Reply-To: <20100602150659.GA5335@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venki@google.com>

On Wed, 2010-06-02 at 23:06 +0800, Matthew Garrett wrote:
> On Wed, Jun 02, 2010 at 11:04:09AM +0800, yakui.zhao@intel.com wrote:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> > The C-state idle time is not calculated correctly, which will return the wrong
> > residency time in C-state. It will have the following effects:
> >    1.  The system can't choose the deeper C-state when it is idle next time.
> > Of course the system power is increased. E.g. On one server machine about 40W
> > idle power is increased.
> >    2.  The powertop shows that it will stay in C0 running state about 95% time
> > although the system is idle at most time.
> 
> What kind of system was this seen on?

This can be seen on laptops. But maybe the idle power effect is not
significant on laptops like that on server machine. 
     I also test the power on one T400 laptop and test shows that about
0.3W idle power is increased. 

thanks.
    Yakui 
> 

