From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 21:42:21 +0200
Message-ID: <200706212142.22426.rjw@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <200706211646.06594.rjw@sisk.pl> <200706210935.59004.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53637 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbXFUTfM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 15:35:12 -0400
In-Reply-To: <200706210935.59004.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday, 21 June 2007 18:35, David Brownell wrote:
> On Thursday 21 June 2007, Rafael J. Wysocki wrote:
> 
> > So, can we make pm_message_t consist only of the target state?
> 
> Let's just finally get rid of pm_message_t.

Fine.  How to we solve the problem at hand, then?


-- 
"Premature optimization is the root of all evil." - Donald Knuth
