From: Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code
 ordering
Date: Wed, 15 Oct 2008 17:49:50 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810151746460.3026@localhost.localdomain>
References: <200810142254.07024.rjw@sisk.pl>
 <20081015085809.GA1061@srcf.ucam.org> <200810151605.35883.rjw@sisk.pl>
 <20081015141526.GA5633@srcf.ucam.org>
 <C075D3D77BA5EF4FBB0939047B182ABF25C79AD3EE@GVW1144EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172073pub.verizon.net ([206.46.172.73]:40507 "EHLO
	vms172073pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYJOVuQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Oct 2008 17:50:16 -0400
In-reply-to: <C075D3D77BA5EF4FBB0939047B182ABF25C79AD3EE@GVW1144EXB.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, John M (WGBU R&D)" <john.brown3@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Matthew,
You are right, of course, we're not doing something right
if a new machine needs this workaround.

However, we don't yet know what we're not doing right:-)

Until we figure that out, the blacklist is a practical way
forward.  There have been several cases in the past where
we grew a blacklist -- some of them quite large,
before we figured out what bug-compatibility
magic we needed in order to delete the blacklist.
I'm hopeful the same story will play out here.

applied.

thanks,
-Len
