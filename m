From: GregR <grcore@usamtb.com>
Subject: Re: 2.6.15-mm2 (acpi-cpufreq not loading)
Date: Fri, 20 Jan 2006 01:36:02 +0000 (UTC)
Message-ID: <loom.20060120T023226-507@post.gmane.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CA52@hdsmsx401.amr.corp.intel.com> <43D00C86.3050403@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51358 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422670AbWATBgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 20:36:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EzlCE-0006Zj-Fk
	for linux-acpi@vger.kernel.org; Fri, 20 Jan 2006 02:36:14 +0100
Received: from c-67-167-90-174.hsd1.il.comcast.net ([67.167.90.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2006 02:36:10 +0100
Received: from grcore by c-67-167-90-174.hsd1.il.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2006 02:36:10 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Brice Goglin <Brice.Goglin <at> ens-lyon.org> writes:

> Yes, modprobe's error is not shown in dmesg (I don't know whether it is
> configurable or not). I just double-checked my boot, I get :

[SNIP]

> In case if matters, acpi-cpufreq is loaded early (in /etc/modules on my
> Debian), before any other acpi modules is loaded (except processor since
> it depends on it).

If it helps, I had the same problem with 2.6.15, and I ended up building it in
[*], as opposed to a module [M] at compile time.  Worked fine after that.

g



