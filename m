From: Pavel Machek <pavel@ucw.cz>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Wed, 5 Dec 2007 11:17:20 +0000
Message-ID: <20071205111720.GC3864@ucw.cz>
References: <20071130142058.816d1693.akpm@linux-foundation.org> <924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1453 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753535AbXLGVVY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 16:21:24 -0500
Content-Disposition: inline
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml@rtr.ca, abelay@novell.com, lenb@kernel.org, mlord@pobox.com, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi!

> >It is not known whether Mark is actually writing to this 
> >thing.  Perhaps
> >read-only permissions would be a suitable fix?
> >
> 
> Exporting it as read only should be OK. We also need to know if there
> are hard user space dependency on writing to this from userspace.

Some people are manipulating it from their suspend scripts..

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
