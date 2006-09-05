From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.18-rc5 -rc5-mm1: kacpid continuously generating 4% CPU load on HPC nx6325 w/ SUSE 10.1
Date: Tue, 5 Sep 2006 13:13:24 +0200
Message-ID: <200609051313.24716.rjw@sisk.pl>
References: <200609031123.02237.rjw@sisk.pl> <200609051447.24820.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48775 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751179AbWIELJ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2006 07:09:56 -0400
In-Reply-To: <200609051447.24820.luming.yu@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Stefan Seyfried <seife@suse.de>

On Tuesday, 5 September 2006 08:47, Yu Luming wrote:
> On Sunday 03 September 2006 17:23, Rafael J. Wysocki wrote:
> > Hi,
> >
> >  I'm having a strange issue with the 2.6.18-rc5 and -rc5-mm1 kernels and
> >  SUSE 10.1 on HPC nx6325 that kacpid is generating 4% of CPU load (on one
> > core) in a continuous manner.
> Please try to unload thermal module.

albercik:~ # rmmod thermal

[hanging? On another console:]
albercik:~ # ps ax
...
4864 pts/0    D+     0:00 rmmod thermal
...

> >  It sometimes helps if powersaved is restarted, but only for a short time.
> >  However, after restarting powersaved the kacpid-generated load sometimes
> > jumps to 100% (on one core) and stays on this level.
> >
> >  At the same time the battery is never reported to be 100% full (it stops
> > at ~98% full and loading) and when I tried to unload the battery module,
> > rmmod ended up in the D state.
> what do you mean by "in the D state"?

TASK_UNINTERRUPTIBLE (like above).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
