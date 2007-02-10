From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Fri, 9 Feb 2007 23:27:03 -0500
Message-ID: <200702092327.04237.lenb@kernel.org>
References: <200702071418.51058.lenb@kernel.org> <20070209230928.GD3949@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44186 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbXBJE23 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 23:28:29 -0500
In-Reply-To: <20070209230928.GD3949@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Accardi, Kristen" <kristen.c.accardi@intel.com>

On Friday 09 February 2007 18:09, Pavel Machek wrote:
> Hi!
> 
> > Per your request, and the request of the distros, we've changed
> > how ACPICA Core releases are integrated into Linux so that each
> > upstream (CVS) check-in appears as a single git commit.
> > While this process is not yet perfect, it should be vastly better
> > than previous "code drops" in allowing git bisect to work,
> > and allowing distros to cherry-pick individual fixes.
> > 
> > The "bay" driver is new (and marked EXPERIMENTAL) -- adding initial
> > hot-plug support for ACPI controlled drive bays such as the
> > IBM ultrabay or the Dell Module Bay.
> 
> Could you describe userland interface it uses? /proc? Will it be
> usable for bays on notebooks not using acpi?

No, Not until somebody finds one and writes code to support it.

> > The "asus-laptop" driver is also new.  Consistent with msi-laptop,
> > it uses ACPI in platform-specific ways, but strives to avoid
> > exposing ACPI-specific implementation details to the user.
> > asus-laptop is mutually exclusive with asus_acpi, which it will
> > replace over time.
> 
> Not including another /proc/acpi/ibm -like nightmare, is it?

No. See discussion on linux-acpi.
I've prohibited new files under /proc/acpi/ for quite some time now.

> > the old /proc/acpi/ interfaces with cleaner interfaces in sysfs --
> > non-ACPI-specific generic ones whenever possible.  This effort
> > is not complete, but it has been in -mm for a long time and
> > I believe that it is time to push it upstream to benefit
> > from broader exposure and testing.
> 
> Does it still include completely broken alarm interface? Can't find it
> in changelogs, so hopefully not.

No. See discussion on linux-acpi.
David Brownell's RTC driver will provide the new RTC interface in sysfs.
/proc/acpi/alarm will go away when the rest of /proc/acpi goes away.

thanks,
-Len
