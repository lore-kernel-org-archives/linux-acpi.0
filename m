From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND] [PATCH] fujitsu-laptop: better handling of P8010 hotkey
Date: Fri, 10 Oct 2008 16:29:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810101624190.7059@localhost.localdomain>
References: <200810090414.m994EeVQ005126@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172073pub.verizon.net ([206.46.172.73]:46599 "EHLO
	vms172073pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761091AbYJJU3c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 16:29:32 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172073.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8J00FIZI97ZCA5@vms172073.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Oct 2008 15:29:32 -0500 (CDT)
In-reply-to: <200810090414.m994EeVQ005126@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org


> diff -ruNp misc-linus/fujitsu-laptop.c misc-jmw/fujitsu-laptop.c

please see "SECTION 1" of Documentation/SubmittingPatches
dunno if this is why your last one didn't apply.

re: Lindent
please don't mix functional and style patches in the same patch,
they should be in a series of multiple patches.  otherwise the
style changes make it impossible to revivew the functional changes.

anyway, this one is in the test tree now.
perhaps you can address dmitry's question?

thanks,
-len

