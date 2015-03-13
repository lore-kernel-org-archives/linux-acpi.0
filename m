From: Arnd Bergmann <arnd@linaro.org>
Subject: Re: [resend PATCH] driver core: property: support for generic property
Date: Fri, 13 Mar 2015 16:24:11 +0100
Message-ID: <2794681.zGttLrs2tn@wuerfel>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <2095371.SrUNK6JsDO@vostro.rjw.lan> <CACxGe6tCJAPJc=Pj7vYiJ-cakvL9EsexGMpOD_G0DEPF3iTguQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56992 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875AbbCMPYQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Mar 2015 11:24:16 -0400
In-Reply-To: <CACxGe6tCJAPJc=Pj7vYiJ-cakvL9EsexGMpOD_G0DEPF3iTguQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Friday 13 March 2015 15:10:38 Grant Likely wrote:
> On Thu, Mar 12, 2015 at 1:41 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, January 26, 2015 03:17:40 PM Heikki Krogerus wrote:
> > That doesn't seem to go in the right direction to be honest.
> >
> > Actually, having introduced struct fwnode_handle, we should perhaps try to
> > replace both of_node and acpi_node with a single struct fwnode_handle pointer
> > and then add a new fwnode_type for the "pdata" stuff.
> 
> I agree on this, but it will be a lot of work to convert...
> 
> > If you don't want to deal with of_node, which I can understand easily, it
> > may be worth trying with acpi_node alone at this point and once you have
> > the fwnode_handle pointer, you might use it for both ACPI and "pdata"?
> >
> > Grant, Arnd, I wonder what you think?
> 
> That makes sense, and we can populate the fwnode_handle even when
> using DT. That will allow a transition period to move everyone over to
> the fwnode_handle.

Agreed on both as well.

	Arnd
