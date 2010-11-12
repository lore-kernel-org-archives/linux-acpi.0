From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] thermal: make ops constant
Date: Fri, 12 Nov 2010 10:20:40 +0000
Message-ID: <20101112102040.3d402252@lxorguk.ukuu.org.uk>
References: <20101111152714.11105.2101.stgit@localhost.localdomain>
	<1289521497.8148.1380.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51908 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752711Ab0KLKVx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Nov 2010 05:21:53 -0500
In-Reply-To: <1289521497.8148.1380.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 12 Nov 2010 08:24:57 +0800
Zhang Rui <rui.zhang@intel.com> wrote:

> On Thu, 2010-11-11 at 23:27 +0800, Alan Cox wrote:
> > From: Alan Cox <alan@linux.intel.com>
> > 
> > And while
> 
> >  touching that function definition
> 
> agreed.
> 
> >  do something about the disaster of formatting there.
> > 
> well. this is what we got after running Lindent.
> Your changes are reverted If I apply your patch and run Lindent again.
> So maybe this is a problem that should be fixed in Lindent?

Lindent is just a script for indent which is designed to help a human not
replace them. It's not something to run automatically over code as it
makes bad mistakes now and then.


Alan
