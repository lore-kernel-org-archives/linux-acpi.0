From: Steven Newbury <steve@snewbury.org.uk>
Subject: Re: Linux 3.11-rc2
Date: Tue, 23 Jul 2013 18:47:55 +0100
Message-ID: <1374601675.29964.15.camel@artifact>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com>
	 <5728692.GlhGgHY92H@vostro.rjw.lan> <1374516979.2641.0.camel@x230>
	 <1943327.gJaLv781Zb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from know-smtprelay-omc-1.server.virginmedia.net ([80.0.253.65]:48313
	"EHLO know-smtprelay-omc-1.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933677Ab3GWRxt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jul 2013 13:53:49 -0400
In-Reply-To: <1943327.gJaLv781Zb@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, James Hogan <james@albanarts.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kamal Mostafa <kamal@canonical.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, 2013-07-22 at 21:56 +0200, Rafael J. Wysocki wrote:
> On Monday, July 22, 2013 06:16:20 PM Matthew Garrett wrote:
> > On Mon, 2013-07-22 at 15:02 +0200, Rafael J. Wysocki wrote:
> > 
> > > In the meantime I received a report from Steven Newbury that these changes
> > > broke things for him too, so we need to revert commits 8c5bd7a and efaa14c.
> > > The other two commits in the series should be benign.
> > 
> > Could you let me know the details of this problem?
> 
> Steven, can you please describe the problem you're seeing to Matthew and
> the other people on the list?
> 
> Rafael
> 

Before the changes backlight was working fine using the ACPI method: 
/sys/class/backlight/acpi_video0/ is present and the keyboard function keys
control brightness with notifications working in GNOME.

In the code as was present in the linux-pm/bleeding-edge tree I would
encounter a hard lockup on keyboard brightness trigger.  This also occurred with
the code as it initially hit mainline, but a later commit fixed the crash*, but
resulted in no backlight controls being available at all.
/sys/class/backlight  is empty.

*not actually sure if /sys/class/backlight contained anything before this


