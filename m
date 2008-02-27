From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: broken suspend in .2.6.25-rc3 on T61p (was Re: new regression in 2.6.25-rc3: no keyboard/lid acpi events on thinkpad T61p)
Date: Wed, 27 Feb 2008 01:12:51 +0100
Message-ID: <200802270112.52652.rjw@sisk.pl>
References: <20080225143932.6b83b65d.akpm@linux-foundation.org> <20080226105606.e56e4ec6.akpm@linux-foundation.org> <2c0942db0802261531s140aaa82w1daa1829b5a36a4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39763 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbYB0AOL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 19:14:11 -0500
In-Reply-To: <2c0942db0802261531s140aaa82w1daa1829b5a36a4a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@codemonkey.org.uk>, kernel list <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, 27 of February 2008, Ray Lee wrote:
> On Tue, Feb 26, 2008 at 10:56 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >  First thing we need to do is to work out why it won't stay suspended?
> 
> Forgive me the stupid question, but you don't happen to have Wake On
> LAN or somesuch enabled in your BIOS, do you? (Given yours stays down
> for five seconds then resumes, and other T61 owners aren't seeing that
> behavior... <shrug>)
> 
> For Pavel and Rafael: Is there some sort of event that gets handed
> back on resume to let the kernel know why the system woke up? One
> would think that the Wake On LAN (keyboard, timer, etc.) would hand a
> notification over to the OS. One is often wrong though.

In theory we should be able to get this kind of information from ACPI, but I've
never seriously looked at that.  I'm not sure if anyone has ...

Thanks,
Rafael
