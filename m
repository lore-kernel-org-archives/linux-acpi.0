From: Holger Macht <hmacht@suse.de>
Subject: Re: [patch 09/11] bay: exit if notify handler cannot be installed
Date: Tue, 10 Jun 2008 10:13:12 +0200
Message-ID: <20080610081311.GA29300@homac>
References: <200806092322.m59NMP01013979@imap1.linux-foundation.org> <20080609232817.GA21101@srcf.ucam.org> <20080609165628.90e2cf7b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33173 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbYFJINA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Jun 2008 04:13:00 -0400
Content-Disposition: inline
In-Reply-To: <20080609165628.90e2cf7b.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com, rui.zhang@intel.com, trenn@suse.de

On Mon 09. Jun - 16:56:28, Andrew Morton wrote:
> On Tue, 10 Jun 2008 00:28:17 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > It looks like the plan is to subsume the bay driver into the dock 
> > driver. I'm not sure if this is needed in the short term until then?
> 
> Dunno.
> 
> This patch appears to fix a bug, in which case we shouldn't allow
> larger future plans to get int he way of that?

Right. I don't think we get the bits sorted for removing the bay driver
for 2.6.26 IMHO, so this should go in as a bugfix for 2.6.26.

Regards,
	Holger
