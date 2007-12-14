From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 2/8] git-acpi build fix
Date: Fri, 14 Dec 2007 02:13:12 +0100
Message-ID: <200712140213.13343.rjw@sisk.pl>
References: <200712132353.lBDNrXRG024821@imap1.linux-foundation.org> <200712140124.33319.rjw@sisk.pl> <20071213162444.1c78c6b7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36884 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbXLNAx4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 19:53:56 -0500
In-Reply-To: <20071213162444.1c78c6b7.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Friday, 14 of December 2007, Andrew Morton wrote:
> On Fri, 14 Dec 2007 01:24:32 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Friday, 14 of December 2007, akpm@linux-foundation.org wrote:
> > > From: Andrew Morton <akpm@linux-foundation.org>
> > > 
> > > ia64 allmodconfig:
> > > 
> > > kernel/power/main.c:493: error: `pm_test_attr' undeclared here (not in a function)
> > 
> > I've already sent a better fix for that, thanks.
> 
> I don't think I was cc'ed.  Please make sure that I see fixes to trees
> which are in -mm?

Well, my mailer testifies that it was To: you and Len.  [I was beating it
really hard, but it wouldn't confess to lying.]
