From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sat, 19 Jan 2008 23:13:09 -0500
Message-ID: <200801192313.10296.lenb@kernel.org>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59808 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbYATENu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 23:13:50 -0500
In-Reply-To: <20080119231916.GK28387@mit.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

Ted, Henrique, Matthew,

Thank you for your wise words.

Here is my plan.

1. notify Intel mobile BIOS group that Linux will STOP answering "yes" to OSI(Linux),
   that they should STOP using OSI(Linux) in their BIOS, and that Linux will
   complain about them when they do.

   I believe this team is the "upstream" cause of the majority of
   OSI(Linux) in the field today.

   I did this last year -- and they were not happy about it.
   The laptops vendors were not happy either.

   However, as it is unsupportable in the long run, I assert we have no choice.

   Yes, we need a mitigation plan, for Linux tries to be Windows compatible,
   but the reality is that we use the platform differently in many areas.
   Graphics and platform specific drivers top the list,
   and a long list of platform workarounds fill it out.

   I am okay with defining OSI strings for the benefit of BIOS vendors that
   need to know about Linux capabilities.  But the string must
   identify that specific capability (or lack of a capability).

   The first on the list would be a way to tell the BIOS that it should
   restore video on S3 resume.  This is off on Windows b/c it is faster
   for a native driver to do it.  But Linux doesn't yet have native drivers
   that can do this.  So we need to be able to ask the BIOS to do this for us
   until we do -- and then we need to be able to _stop_ asking the BIOS
   when we have native graphics driver support in place.  (This is an example
   of why "Linux" is a poor choice for a capability string -- once you use it,
   when can you _stop_ using it?)

2. Transition Linux from OSI(Linux) to !OSI(Linux)

   Linux-2.6.21 was the last kernel with OSI(Linux) by default w/o complaint.
   Linux-2.6.22 was the last kernel with OSI(Linux) by default, but it complains.
   Linux-2.6.23 was the first kernel with !OSI(Linux) by default, and it still complains.

3. Clean up any wreckage

   That is where we are now.  The goal is to identify the products that
   really do need OSI(Linux) and help them keep shipping.

   There are 3 types of OSI(Linux) users:

   1) most laptops with OSI(Linux) inherited it from the refernece code
      and don't actually use it for anything.

      Linux will complain about these, until we get their DMI and
      tell Linux to stop complaining.  But with or without DMI,
      OSI(Linux) is off for these systems.

   2) laptops where OSI(Linux) causes a failure.
      This is the case I'm most worried about, because
      it is just like the _OS=Linux issue in the old days,
      which means it has unbounded risk of failure in the field.

      As the default in 2.6.23 and later is to disable OSI(Linux)
      these systems work by default going forward,
      and we just need their DMI to quiet them up,
      like we did for case #1.  I do actually use an
      OSI-disable DMI hook for these rather than an OSI-ignore DMI,
      in case somebody wants to build the kernel with it enabled by default.

   3) OSI(Linux) added by the vendor that actually makes a Linux SKU work.
      The good/bad news is that there are very few real laptop Linux SKUs,
      so indentifying them and dealing with them is finite.

      As OSI(Linux) is disabled by default today, any vendor
      that wants it to be enabled for their product will have
      to get a change into Linux, whether it be a bootparam
      or a white-list entry.  I think having this barrier to
      entry is good, in that it is motivation to avoid doing the wrong thing.

thanks,
-Len

ps. I say laptops above.  I've seen OSI(Linux) on a few Dell desktops,
    but otherwise I've only seen it spread to laptops.
