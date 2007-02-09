From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Fri, 9 Feb 2007 23:09:29 +0000
Message-ID: <20070209230928.GD3949@ucw.cz>
References: <200702071418.51058.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946767AbXBIXz7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200702071418.51058.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Accardi, Kristen" <kristen.c.accardi@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Per your request, and the request of the distros, we've changed
> how ACPICA Core releases are integrated into Linux so that each
> upstream (CVS) check-in appears as a single git commit.
> While this process is not yet perfect, it should be vastly better
> than previous "code drops" in allowing git bisect to work,
> and allowing distros to cherry-pick individual fixes.
> 
> The "bay" driver is new (and marked EXPERIMENTAL) -- adding initial
> hot-plug support for ACPI controlled drive bays such as the
> IBM ultrabay or the Dell Module Bay.

Could you describe userland interface it uses? /proc? Will it be
usable for bays on notebooks not using acpi?

> The "asus-laptop" driver is also new.  Consistent with msi-laptop,
> it uses ACPI in platform-specific ways, but strives to avoid
> exposing ACPI-specific implementation details to the user.
> asus-laptop is mutually exclusive with asus_acpi, which it will
> replace over time.

Not including another /proc/acpi/ibm -like nightmare, is it?

> the old /proc/acpi/ interfaces with cleaner interfaces in sysfs --
> non-ACPI-specific generic ones whenever possible.  This effort
> is not complete, but it has been in -mm for a long time and
> I believe that it is time to push it upstream to benefit
> from broader exposure and testing.

Does it still include completely broken alarm interface? Can't find it
in changelogs, so hopefully not.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
