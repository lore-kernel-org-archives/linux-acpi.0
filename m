From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.18-rc5 -rc5-mm1: kacpid continuously generating 4% CPU load on HPC nx6325 w/ SUSE 10.1
Date: Tue, 5 Sep 2006 23:48:05 +0200
Message-ID: <200609052348.06063.rjw@sisk.pl>
References: <200609031123.02237.rjw@sisk.pl> <44FDA39F.3060302@linux.intel.com> <200609052224.58749.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33676 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751493AbWIEVpR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2006 17:45:17 -0400
In-Reply-To: <200609052224.58749.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Yu Luming <luming.yu@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Stefan Seyfried <seife@suse.de>

On Tuesday, 5 September 2006 22:24, Rafael J. Wysocki wrote:
> On Tuesday, 5 September 2006 18:19, Alexey Starikovskiy wrote:
> > Please try a patch from #5534 bug report, it seems you have the same deadlock as all other HP users.
> 
> Well, could you please tell me which comments are you referring to?
> 
> The fans seem to work correctly on this box.

Apparently I was wrong.

I used the patch from Bug #5534 Comment #95 and it seems to have fixed the
kacpid issue.  Also, I'm now able to remove the ACPI modules.

Thanks a lot for the hint!

Greetings,
Rafael
