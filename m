From: Arnaldo Carvalho de Melo <acme-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Subject: [PATCHES] convert acpi to seq_file
Date: Sat, 23 Nov 2002 15:02:29 -0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021123170229.GF25766@conectiva.com.br>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A50E@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A50E-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Em Thu, Nov 14, 2002 at 02:34:35PM -0800, Grover, Andrew escreveu:
> > From: Arnaldo Carvalho de Melo [mailto:acme-KCZ47A4bww4P48s/oLjRZg@public.gmane.org] 
> > 	Please consider pulling from:
> > 
> > bk://oops.kerneljanitors.org:acpi-2.5
> > 
> > 	This is the first in a series of changesets converting
> > ACPI to seq_file, please lets us know if something is unacceptable.
> > 
> > 	The work was done by Aristeu Rozanski.
> 
> Hi acme,
> 
> Looks like an improvement. My thanks to you and Aristeu.
> 
> Let me know when you're done with all the changesets and I'll pull
> everything.

Andrew,

	Sorry for the delay, now you can pull all from:

bk://oops.kerneljanitors.org:acpi-2.5

or 

master.kernel.org:/home/acme/BK/acpi-2.5

Here is a summary of what was done:

ChangeSet-3IgRKU1URtA@public.gmane.org, 2002-11-23 14:34:10-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/toshiba_acpi.c to seq_file

ChangeSet-++Osl01uawE@public.gmane.org, 2002-11-23 14:20:41-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/thermal.c

ChangeSet-vEVhliDTK2g@public.gmane.org, 2002-11-23 14:13:27-02:00, acme@conectiva.com.br
  o acpi/processor.o: fix up seq_file conversion, add missing comma

ChangeSet-f8zJvkENqGY@public.gmane.org, 2002-11-23 13:57:42-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/sleep.c to seq_file

ChangeSet-ZPKE0WbzUUI@public.gmane.org, 2002-11-23 13:45:39-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/processor.c to seq_file

ChangeSet-1poInSeHITs@public.gmane.org, 2002-11-23 13:37:09-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/power.c to seq_file

ChangeSet-UWfmiOT6l9fkfKl135yGWg@public.gmane.org, 2002-11-15 05:43:42-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/button.c to seq_file

ChangeSet-UWfmiOT6l9dbgfau97FWYA@public.gmane.org, 2002-11-13 19:35:45-02:00, aris@cathedrallabs.org
  drivers/acpi/ac.c: convert to seq_file


Best Regards,

- Arnaldo
