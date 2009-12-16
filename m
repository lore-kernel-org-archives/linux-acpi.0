From: Len Brown <lenb@kernel.org>
Subject: Re: Dock OOPSing with recent acpi-test
Date: Wed, 16 Dec 2009 01:31:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912160130310.30935@localhost.localdomain>
References: <200911180958.34121.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:36946 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626AbZLPGbk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 01:31:40 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00JHHFGRGG2I@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 00:31:39 -0600 (CST)
In-reply-to: <200911180958.34121.dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>

On Wed, 18 Nov 2009, Dmitry Torokhov wrote:

> The day before yesterday pull from acpi-test + Linux's tip produces the
> following oops in the dock driver (see screenshot).

Dmitry, do you still see this?
If you build with drivers/acpi/dock.c from 2.6.32 does it go away?

thanks,
-Len

