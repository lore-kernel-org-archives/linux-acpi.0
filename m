From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 09/11] bay: exit if notify handler cannot be installed
Date: Wed, 11 Jun 2008 10:31:25 +0800
Message-ID: <1213151485.20657.0.camel@sli10-desk.sh.intel.com>
References: <200806092322.m59NMP01013979@imap1.linux-foundation.org>
	 <20080609232817.GA21101@srcf.ucam.org>
	 <20080609165628.90e2cf7b.akpm@linux-foundation.org>
	 <20080610081311.GA29300@homac>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36511 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589AbYFKCZp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Jun 2008 22:25:45 -0400
In-Reply-To: <20080610081311.GA29300@homac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, trenn@suse.de

On Tue, 2008-06-10 at 16:13 +0800, Holger Macht wrote:
> On Mon 09. Jun - 16:56:28, Andrew Morton wrote:
> > On Tue, 10 Jun 2008 00:28:17 +0100
> > Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >
> > > It looks like the plan is to subsume the bay driver into the dock
> > > driver. I'm not sure if this is needed in the short term until
> then?
> >
> > Dunno.
> >
> > This patch appears to fix a bug, in which case we shouldn't allow
> > larger future plans to get int he way of that?
> 
> Right. I don't think we get the bits sorted for removing the bay
> driver
> for 2.6.26 IMHO, so this should go in as a bugfix for 2.6.26.
agree, removing the bay driver isn't 2.6.26 staff.

