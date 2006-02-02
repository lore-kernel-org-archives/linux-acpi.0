From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Thu, 2 Feb 2006 17:43:47 -0500
Message-ID: <20060202224347.GL11831@redhat.com>
References: <20060202222407.GB896@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:61078 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932407AbWBBWoO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2006 17:44:14 -0500
Content-Disposition: inline
In-Reply-To: <20060202222407.GB896@sommrey.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Tony Lindgren <tony@atomide.com>, "Brown, Len" <len.brown@intel.com>, Erik Slagter <erik@slagter.name>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, Feb 02, 2006 at 11:24:07PM +0100, Joerg Sommrey wrote:

 > +- Occasional hard lockups might be caused by amd76x_pm.  I'm still working
 > +  on this issue.

We've had users report lockups, random oopses and other problems
with lvcool and amd76x_pm in the past, that went away when the
module.  The lack of understanding of this problem makes me inclined
to say that this shouldn't get merged upstream until it's solved.

If it does get merged, it's not something I intend to enable
in a distro kernel for some time, if at all.

		Dave

