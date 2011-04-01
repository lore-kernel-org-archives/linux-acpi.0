From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/3] acpi: Split out custom_method functionality into an own driver
Date: Fri, 1 Apr 2011 09:47:54 +0200
Message-ID: <201104010947.54969.trenn@suse.de>
References: <1301571400-9861-1-git-send-email-trenn@suse.de> <1301571400-9861-3-git-send-email-trenn@suse.de> <201103312341.24612.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37308 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189Ab1DAHr5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Apr 2011 03:47:57 -0400
In-Reply-To: <201103312341.24612.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Thursday, March 31, 2011 11:41:24 PM Rafael J. Wysocki wrote:
> On Thursday, March 31, 2011, Thomas Renninger wrote:
> > With /sys/kernel/debug/acpi/custom_method root can write
> > to arbitrary memory and increase his priveleges, even if
> > these are restricted.
> > 
> > -> Make this an own debug .config option and warn about the
> > security issue in the config description.
> > 
> > -> Still keep acpi/debugfs.c which now only creates and empty
> >    /sys/kernel/debug/acpi directory. There might be other
> >    users of it later.
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > CC: Rafael J. Wysocki <rjw@sisk.pl>
> > CC: lenb@kernel.org
> > CC: rui.zhang@intel.com
> > CC: linux-acpi@vger.kernel.org
> > ---
> >  Documentation/acpi/method-customizing.txt |    5 ++
> >  drivers/acpi/Kconfig                      |   15 +++++
> >  drivers/acpi/Makefile                     |    1 +
> >  drivers/acpi/debugfs.c                    |   80 
+----------------------------
> >  4 files changed, 22 insertions(+), 79 deletions(-)
> 
> Did you forget to custom_method.c ?
Indeed. Happened already, looks like I need a guilt add
again after guilt push -f, no idea.

Resend coming in a second.

Thanks,

   Thomas
