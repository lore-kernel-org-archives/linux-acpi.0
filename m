From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] Revert "ACPI / AC: convert ACPI ac driver to
 platform bus"
Date: Wed, 7 May 2014 16:31:55 -0700
Message-ID: <20140507233155.GA14406@roeck-us.net>
References: <1399429108-15395-1-git-send-email-linux@roeck-us.net>
 <6536976.HgJVm3ut0E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36118 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbaEGXcF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2014 19:32:05 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so1811826pab.31
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2014 16:32:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6536976.HgJVm3ut0E@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Manuel Krause <manuelkrause@netscape.net>

On Thu, May 08, 2014 at 01:43:55AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, May 06, 2014 07:18:28 PM Guenter Roeck wrote:
> > This reverts commit cc8ef52707341e67a12067d6ead991d56ea017ca.
> > 
> > This is an attempt to fix (or at least track down)
> > https://bugzilla.kernel.org/show_bug.cgi?id=71711.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Manuel Krause <manuelkrause@netscape.net>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Conflicts:
> > 	drivers/acpi/ac.c
> > 	drivers/acpi/acpi_platform.c
> 
> Queued up as a fix for 3.15, thanks!
> 

It should also find its way into 3.14.

Thanks,
Guenter
