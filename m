From: "Andrea R." <7252d9@gmail.com>
Subject: Re: [2.6.27.7] processor.ko messes up ACPI resume
Date: Fri, 17 Jul 2009 10:50:23 +0200
Message-ID: <20090717085023.GB2016@acerrimo>
References: <20090711131152.GE2750@acerrimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpi4.ngi.it ([88.149.128.34]:39983 "EHLO smtpi4.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934226AbZGQIuc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Jul 2009 04:50:32 -0400
Received: from 127.0.0.1 (81-174-3-254.dynamic.ngi.it [81.174.3.254])
	by smtpi4.ngi.it (Postfix) with ESMTP id 4DF9A420D1
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2009 10:50:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090711131152.GE2750@acerrimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Il 11/07/2009 alle 15:11, Andrea R. ha scritto:

> Hi all,
> 
> I was having problems resuming my Acer laptop from suspend-to-RAM, where
> upon waking up the screen was flashing madly (think detuned TV). This
> laptop had no problems waking up using previous kernel releases, the
> latest I had tried before 2.6.27 being 2.6.18.
> 
> After long trials, I traced the issue to the "processor.ko" kernel
> module: if I unload it - even while the screen is being crazy - all goes
> back to normal.
> 
> Problem is, that module is needed to probe the CPU's temperature and - I
> think - for clock frequency stepping.
> 
> Does anyone know how do I get to keep it *and* get working resume
> functionality?
> 
> I'm using 32-bit Slackware 12.2 at the moment, but the exact same
> symptoms were shown by Fedora 11 x86_64.
> 
> My laptop has an AMD Turion64 processor and an ATI Radeon Xpress1100
> graphics card driven by X.Org's "ati" driver. Please write if you need
> lspci's output or more detailed info or tests.
> 
> Thanks in advance for your comments.


Good thing I thanked in advance...


-- 
~> cat /etc/*-{version,release}|head -n1 && uname -moprs|fold -sw72
Slackware 12.2.0
Linux 2.6.27.7-crrm i686 AMD Turion(tm) 64 Mobile Technology MK-36 
GNU/Linux
