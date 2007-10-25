From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with ACPI Operation Region resources
Date: Thu, 25 Oct 2007 08:04:38 -0400
Message-ID: <20071025120438.GJ30546@jupiter.solarsys.private>
References: <1193236319.4590.225.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759494AbXJYMGV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1193236319.4590.225.camel@queen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>
List-Id: linux-acpi@vger.kernel.org

Hi Thomas:

I recently told someone in private that ACPI vs. hwmon conflicts are the
biggest open problems for the hwmon subsystem.  Thank you (and Jean) for
doing this.

* Thomas Renninger <trenn@suse.de> [2007-10-24 16:31:59 +0200]:
> Hi,
> 
> it seems Len's test tree and Linus tree diverged a bit, at least with
> this patch set things do not apply cleanly.
> 
> Therefore I post these for discussion whether and in which kernel tree
> they should end up before doing work for nothing.
> If they are still a candidate for 2.6.24 (rather unintrusive), pls tell
> me whether and when I should base them against Len's test/release branch
> or whatever other tree.
> If not, it would be great if they can be included into the -mm tree and
> I can rebase them against this one.

Andrew has already picked this series; I vote for extended time in -mm.  On the
hwmon side, there is almost guaranteed to be fallout from this that may take
time to resolve.

> (...)

> A boot parameter acpi_enforce_resources=strict/lax/no is provided, which
> is default set to lax:
>   - strict: let conflicting drivers fail to load with an error message
>   - lax:    let conflicting driver work normal with a warning message
>   - no:     no functional change at all
> Depending on the feedback and the kind of interferences we see, this
> should be set to strict at later time.

As long as it's in -mm, you may as well default to =strict right away.  This
will force people to report.  Open the floodgates; I hope I don't drown.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
