From: Alex Chiang <achiang@hp.com>
Subject: Re: Dock OOPSing with recent acpi-test
Date: Tue, 15 Dec 2009 23:45:25 -0700
Message-ID: <20091216064525.GB20352@ldl.fc.hp.com>
References: <200911180958.34121.dmitry.torokhov@gmail.com> <alpine.LFD.2.00.0912160130310.30935@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:36054 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbZLPGp0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 01:45:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912160130310.30935@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org

* Len Brown <lenb@kernel.org>:
> On Wed, 18 Nov 2009, Dmitry Torokhov wrote:
> 
> > The day before yesterday pull from acpi-test + Linux's tip produces the
> > following oops in the dock driver (see screenshot).
> 
> Dmitry, do you still see this?
> If you build with drivers/acpi/dock.c from 2.6.32 does it go away?

I figured out what the issue was:

http://www.spinics.net/lists/linux-acpi/msg25223.html

+static int
+add_dock_dependent_device(acpi_handle handle, struct dock_station *ds)

...

+	if (tmp == ds->handle)
+		add_dock_dependent_device(ds, handle);

...

+	ret = add_dock_dependent_device(dock_station, handle);
+	if (ret)
 		goto err_rmgroup;

I wrote the function signature one way, but called it a different
way. How odd, I never got a compiler type warning (that I can
recall).

Queueing up a patch for Len now.

Sorry about that.
/ac

