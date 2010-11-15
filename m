From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: make ops constant
Date: Mon, 15 Nov 2010 08:45:25 +0800
Message-ID: <1289781925.8148.1813.camel@rui>
References: <20101111152714.11105.2101.stgit@localhost.localdomain>
	 <1289521497.8148.1380.camel@rui>
	 <20101112102040.3d402252@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39125 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab0KOAny (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Nov 2010 19:43:54 -0500
In-Reply-To: <20101112102040.3d402252@lxorguk.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2010-11-12 at 18:20 +0800, Alan Cox wrote:
> On Fri, 12 Nov 2010 08:24:57 +0800
> Zhang Rui <rui.zhang@intel.com> wrote:
> 
> > On Thu, 2010-11-11 at 23:27 +0800, Alan Cox wrote:
> > > From: Alan Cox <alan@linux.intel.com>
> > > 
> > > And while
> > 
> > >  touching that function definition
> > 
> > agreed.
> > 
> > >  do something about the disaster of formatting there.
> > > 
> > well. this is what we got after running Lindent.
> > Your changes are reverted If I apply your patch and run Lindent again.
> > So maybe this is a problem that should be fixed in Lindent?
> 
> Lindent is just a script for indent which is designed to help a human not
> replace them. It's not something to run automatically over code as it
> makes bad mistakes now and then.
> 
Oh, I used to run it first when a new file is introduced, although the
result doesn't look quite good for me sometimes.
Thanks for the correction.

thanks,
rui


