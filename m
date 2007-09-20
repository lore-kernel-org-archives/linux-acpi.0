From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: suspend: consolidate handling of Sx states.
Date: Thu, 20 Sep 2007 23:05:07 +0200
Message-ID: <200709202305.07743.rjw@sisk.pl>
References: <20070920173235.7675.6618.stgit@samsung> <200709202200.04270.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40193 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbXITUwf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Sep 2007 16:52:35 -0400
In-Reply-To: <200709202200.04270.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Thursday, 20 September 2007 22:00, Rafael J. Wysocki wrote:
> On Thursday, 20 September 2007 19:32, Alexey Starikovskiy wrote:
> > Recent changes to sleep initialization in ACPI dropped reporting of supported Sx 
> > states above S3. Fix that and also move S5 init into same file as other Sx.
> 
> Well, that's a result of one of my patches.  Thanks for fixing!
> 
> > The only functional change is adding printk() for S4 and S5 cases.
> > 
> > Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

BTW, it clashes with your previous patch:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23-rc7/patches/32-ACPI-Clean-up-GPE-handling-across-suspend_resume-for-wake-up-devices.patch

a bit, so I have fixed it up.  Please have a look:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23-rc7/patches/38-ACPI-suspend-consolidate-handling-of-Sx-states.patch

Greetings,
Rafael
