From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: fix regression on D3hot detection
Date: Tue, 15 May 2012 19:28:35 +0200
Message-ID: <201205151928.36026.rjw@sisk.pl>
References: <5165867.6kdtKH1k0B@penguin> <201205151747.43197.rjw@sisk.pl> <1430051.zWhrZKIcmE@penguin>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:46117 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965223Ab2EORXk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 May 2012 13:23:40 -0400
In-Reply-To: <1430051.zWhrZKIcmE@penguin>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lekensteyn <lekensteyn@gmail.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, May 15, 2012, Lekensteyn wrote:
> On Tuesday 15 May 2012 17:47:43 you wrote:
> > On Tuesday, May 15, 2012, Lekensteyn wrote:
> > > Commit 1cc0c998fdf2cb665d625fb565a0d6db5c81c639 tried clear up some
> > > confusion around D3hot and D3cold but accidentally changed behaviour on
> > > validating device power states. It added an extra condition: i <
> > > ACPI_STATE_D3_HOT which means that only states D0, D1 and D2 are accepted
> > > if there are no power resources but the _PSx method exist. D3(hot) is
> > > missing here.
> > 
> > Which is intentional (that follows from the ACPI spec.).
> Now that I am reading it back, this patch invalidates the comment in the code 
> and could be achieved by removing the whole i < ... condition (because that is 
> the for-loop condition too). In the ACPI spec [1], I cannot find a statement 
> that D3 is invalid if there is no _PR3 state. Do you have a reference for the 
> behaviour?

Yes, pretty much.  ACPI 4.0 Section 7.2.10 _PR3 (Power Resources for D3hot)
says:

"Platform/drivers must assume that the device will have power completely
removed when the device is place[d] into "D3" via _PS3."

This basically means that if _PR3 is not present, we must assume that _PS3
puts the device into D3cold.

> About the linked bug, I do not see any _PR3 methods on at least 258 Optimus 
> machines (acpidumps for a lot hybrid graphics machines [2]) although the _PS3 
> methods on those machines really put the device in a lower power state.

That's correct and that state is D3cold.

Thanks,
Rafael
