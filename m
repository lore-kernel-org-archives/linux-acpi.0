From: "Grover, Andrew" <andrew.grover@intel.com>
Subject: RE: [BK PATCH] ACPI updates
Date: Thu, 5 Dec 2002 17:36:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
To: 'Pavel Machek' <pavel@ucw.cz>
Cc: 'Arjan van de Ven' <arjanv@redhat.com>, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
List-Id: linux-acpi@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz] 

I (Andy) said:
> > Well maybe that's what we should do - use the UnitedLinux 
> ACPI patch (which
> > iirc is based on fairly recent ACPI code, and presumably minimizes
> > ACPI-related breakage) and then proceed incrementally from there?
> > 
> > Sound OK? Marcelo? UL folks?

> I guess it will be better if you push acpi patch without killing those
> backup solutions. Extractign blacklist from UL might be worth it,
> through.

Well after communicating with Marcelo it sounds like he'd like to hold off
taking it in 2.4.21 because IDE changes take priority, and two big changes
at once is too many for a stable kernel revision.

Fair enough. I'm just worried that 2.4.22 is a long ways away.

Maybe one way to address Marcelo's stability concerns and Arjan's "keep
acpitable.[ch] around" preference is for me to submit a patch that I *know*
don't affect anything besides ACPI -- i.e. only the changes that have been
made under drivers/acpi, and then go from there, submitting UL-derived and
other improvements incrementally after that.

Thoughts?

Regards -- Andy
