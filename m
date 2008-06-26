From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor register on resume
Date: Thu, 26 Jun 2008 10:39:59 +0200
Message-ID: <200806261040.00646.rjw@sisk.pl>
References: <200806242303.49498.rjw@sisk.pl> <20080626011716.e8c412dd.akpm@linux-foundation.org> <20080626082943.GC10973@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56992 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbYFZIiI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 04:38:08 -0400
In-Reply-To: <20080626082943.GC10973@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@suse.cz>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday, 26 of June 2008, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > Len seems to think that Rafael seems to think that Ingo seems to think 
> > that this patch broke one of his boxes.
> > 
> > Is it so?
> 
> No! :-)
> 
> it found a pre-existing suspend+resume breakage on a testbox. (I.e. the 
> debug patch worked as i'd expect it to work. Every good debug patch 
> starts its lifetime with a sharp spike of breakages it finds.)

Does it mean that the $subject patch doesn't break your test box after all?

Rafael
