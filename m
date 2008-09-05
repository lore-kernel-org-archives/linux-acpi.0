From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Problem with ACPI video
Date: Fri, 05 Sep 2008 09:02:41 +0800
Message-ID: <1220576561.24775.266.camel@rzhang-dt>
References: <g9n0h0$ru8$1@ger.gmane.org>
	 <1220491149.24775.229.camel@rzhang-dt>  <48C03A87.5050109@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51680 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbYIEBDc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 21:03:32 -0400
In-Reply-To: <48C03A87.5050109@sapo.pt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luis Henriques <henrix@sapo.pt>
Cc: linux-acpi@vger.kernel.org

On Fri, 2008-09-05 at 03:44 +0800, Luis Henriques wrote:
> Zhang Rui wrote:
> >> It seems that acpi_video_bus_add function is invoked twice and, the
> >> second time, it fails (maybe it is supposed to be invoked
> twice...).
> >>
> > There are two ACPI video bus devices both named "VGA" in the ACPI
> > namespace, and each of them tries to create an entry "VGA"
> > under /proc/acpi/video/.
> > that's why this message is printed out.
> 
> Sorry about my ignorance on the topic but... does this mean I do
> actually have 2 devices?  If this is true, then I should actually have
> "VGA1" and "VGA2" dirs in /proc, right?
No, because the video driver tries to register two "VGA" procfs entry,
we get two "VGA" dirs in /proc...

> >> Please let me know whether you need any additional information to
> help
> >> me solving this problem.
> > There is a patch from Matthew that should solve this problem, which
> has
> > already hit the acpi test tree.
> > it would be great if you can get the source code and give it a
> try. :)
> >
> > how to get the source code:
> >> git-clone
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6
> acpi_test
> >> git-branch -r
> >> git-branch --track test origin/test
> >> git-checkout test
> 
> 
> Ok, tried this (or similar...) and it seems to be working just fine.
> Or, at least, no more error message from kernel.  Also, in
> /proc/acpi/video only one directory 'VGA' is being created.  Here's
> the
> relevante dmesg part:
> 
> [   14.657009] ACPI: AC Adapter [ACAD] (on-line)
> [   14.661005] acpi device:04: registered as cooling_device2
> [   14.664019] input: Video Bus as /class/input/input4
> [   14.716892] ACPI: Video Device [VGA] (multi-head: yes  rom: no
> post: no)
> 
that's great.
thanks for testing, we'll try to push these patches upstream.

thanks,
rui

