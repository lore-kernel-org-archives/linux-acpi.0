From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 3 May 2007 14:53:35 +0200
Message-ID: <200705031453.36459.rjw@sisk.pl>
References: <200705022213.35831.rjw@sisk.pl> <1178194332.13233.98.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53169 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161883AbXECMtP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 08:49:15 -0400
In-Reply-To: <1178194332.13233.98.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>

On Thursday, 3 May 2007 14:12, Johannes Berg wrote:
> On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:
> 
> >  extern void swsusp_unset_page_free(struct page *);
> >  extern unsigned long get_safe_page(gfp_t gfp_mask);
> 
> > +void hibernation_set_ops(struct hibernation_ops *ops);
> 
> > +extern int hibernate(void);
> 
> You could add an extern to hibernation_set_ops for consistency :) Not
> that I really care.

Will add, thanks.

Rafael
