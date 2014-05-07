From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] Revert "ACPI / AC: convert ACPI ac driver to platform bus"
Date: Thu, 08 May 2014 01:50:26 +0200
Message-ID: <2440587.zkE99e14QY@vostro.rjw.lan>
References: <1399429108-15395-1-git-send-email-linux@roeck-us.net> <6536976.HgJVm3ut0E@vostro.rjw.lan> <20140507233155.GA14406@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59161 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752762AbaEGXdq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2014 19:33:46 -0400
In-Reply-To: <20140507233155.GA14406@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Manuel Krause <manuelkrause@netscape.net>

On Wednesday, May 07, 2014 04:31:55 PM Guenter Roeck wrote:
> On Thu, May 08, 2014 at 01:43:55AM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, May 06, 2014 07:18:28 PM Guenter Roeck wrote:
> > > This reverts commit cc8ef52707341e67a12067d6ead991d56ea017ca.
> > > 
> > > This is an attempt to fix (or at least track down)
> > > https://bugzilla.kernel.org/show_bug.cgi?id=71711.
> > > 
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Cc: Manuel Krause <manuelkrause@netscape.net>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Conflicts:
> > > 	drivers/acpi/ac.c
> > > 	drivers/acpi/acpi_platform.c
> > 
> > Queued up as a fix for 3.15, thanks!
> > 
> 
> It should also find its way into 3.14.

I've marked it for -stable too.  Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
