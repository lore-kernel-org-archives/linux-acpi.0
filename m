From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] ACPI toshiba: only register rfkill if bt is enabled
Date: Sun, 16 Nov 2008 17:44:31 +0100
Message-ID: <200811161744.31777.rjw@sisk.pl>
References: <20081029081934.GB26314@gambetta> <200811161340.36798.rjw@sisk.pl> <200811161550.49957.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42559 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbYKPQj3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 11:39:29 -0500
In-Reply-To: <200811161550.49957.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Frederik Deweerdt <frederik.deweerdt@xprog.eu>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, philipl@overt.org

On Sunday, 16 of November 2008, Andrey Borzenkov wrote:
> On Sunday 16 November 2008, Rafael J. Wysocki wrote:
> > On Sunday, 16 of November 2008, Andrey Borzenkov wrote:
> > > On Wednesday 29 October 2008, Frederik Deweerdt wrote:
> > > > [resending as it didn't make it to the list, removing netdev from cc
> > > > also]
> > > > Hello  Andrey,
> > > > 
> > > > It looks like a part of the rfkill initialization was done whenever
> > > > BT was on or not. The following patch checks for BT presence before
> > > > registering the rfkill to the input layer. Does it solve the problem for
> > > > you?
> > > > 
> > > 
> > > This patch fixes regression in 2.6.28. Patch has been tested and
> > > acnowledged. Rafael, could you add it to list of open regressions?
> > > Thank you!
> > 
> > I will, if you provide me with a link to the patch and (optionally) to the
> > original bug report.
> > 
> 
> Original bug report:
> http://marc.info/?l=linux-kernel&m=122522113619025&w=2
> 
> Patch:
> http://marc.info/?l=linux-kernel&m=122526843117478&w=2

Thanks, added to the list as http://bugzilla.kernel.org/show_bug.cgi?id=12047

Best,
Rafael
