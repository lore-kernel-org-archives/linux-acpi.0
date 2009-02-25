From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Wed, 25 Feb 2009 16:18:25 +0000
Message-ID: <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lifesci.dundee.ac.uk ([134.36.67.240]:53300 "EHLO
	frigg.compbio.dundee.ac.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752082AbZBYQnp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Feb 2009 11:43:45 -0500
In-Reply-To: <20090225152409.GA4015@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net


On Wed, 2009-02-25 at 15:24 +0000, Matthew Garrett wrote:
> On Wed, Feb 25, 2009 at 09:54:43AM -0500, Charles@schwieters.org wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > 
> > Hello--
> > 
> >   Please apply the following patch to toshiba_acpi.c. This patch has
> > existed for about five years and is necessary for proper operation of
> > some tools on toshiba laptops with toshiba BIOSes (such as toshset
> > http://www.schwieters.org/toshset/). 
> 
> Why are the toshset features not being added to the toshiba_acpi driver?
> 

Because it makes far more sense to have a user mode program to drive the
features, and for the kernel to provide the necessary thin layer to
access the features.

JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.

