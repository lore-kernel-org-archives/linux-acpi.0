From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/2] ACPICA: add postorder namespace walk
Date: Fri, 31 Jul 2009 14:14:45 -0600
Message-ID: <200907311414.46249.bjorn.helgaas@hp.com>
References: <20090717172248.24968.31911.stgit@bob.kio> <200907311217.18761.bjorn.helgaas@hp.com> <4911F71203A09E4D9981D27F9D83085832C8B04E@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:20736 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZGaUOr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 16:14:47 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D83085832C8B04E@orsmsx503.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday 31 July 2009 01:26:20 pm Moore, Robert wrote:
> We've been wrapping up ACPI 4.0 changes. I hope to take a look at this next week.

Oh, right, I saw mail about that a day or two ago and figured you
must be pretty busy :-)  I do hope to use the postorder traversal,
but there are still some significant Linux issues to work out first,
so there's no big rush.

Bjorn

> >-----Original Message-----
> >From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
> >Sent: Friday, July 31, 2009 11:17 AM
> >To: Moore, Robert
> >Cc: Len Brown; linux-acpi@vger.kernel.org
> >Subject: Re: [PATCH 0/2] ACPICA: add postorder namespace walk
> >
> >On Friday 17 July 2009 11:27:16 am Bjorn Helgaas wrote:
> >> AcpiWalkNamespace() only supports preorder traversal of the namespace.
> >> This visits a node before any of its children, so it works well for
> >> adding new devices.  However, when removing devices, we need a postorder
> >> traversal so we can remove children before the parents.
> >>
> >> These patches add a new AcpiWalkNamespace2() interface that takes two
> >> callback arguments: one for preorder traversal and another for postorder.
> >> These patches don't change the behavior of AcpiWalkNamespace().
> >>
> >> Note that the existing preorder AcpiWalkNamespace() never actually visits
> >> the starting node.  Therefore, we skip it in postorder also.
> >
> >Hi Bob,
> >
> >Any feedback on these patches, or on the question of whether
> >AcpiWalkNamespace() should visit the starting node?  (I expect
> >that the starting node question will be most easily resolved
> >by a documentation update.)
> >
> >Bjorn
> >
> 
> 


