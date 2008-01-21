From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Mon, 21 Jan 2008 14:00:41 -0500
Message-ID: <20080121190041.GD29792@mit.edu>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801192313.10296.lenb@kernel.org> <47933886.7050401@dbservice.com> <200801201331.59478.lenb@kernel.org> <20080121015238.GA8105@mit.edu> <20080121095000.GA2785@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:64131 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753420AbYAUTBD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 14:01:03 -0500
Content-Disposition: inline
In-Reply-To: <20080121095000.GA2785@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Tomas Carnecky <tom@dbservice.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Mon, Jan 21, 2008 at 09:50:00AM +0000, Matthew Garrett wrote:
> > Maybe we should define the S3 video strong right away, along with
> > whatever else Lenovo was trying to use OSI(Linux) for, and then get
> > the distro's to ship Errata kernels that answer yes for those
> > questions ASAP.  
> 
> I'd prefer to figure out what they're actually doing with it, since 
> clearly Windows doesn't need this. I'm not especially comfortable with 
> the S3 video stuff, but it seems safer - I just strongly suspect that 
> giving vendors a "Please reinitialise video when exiting S3" option will 
> be abused as a general "Linux" indicator.

Well, unless until Video card vendors give us their secret interfaves
to reinitialize their cards, we're never going to figure it out,
right?  At least for vendors like Lenovo, where some laptops will be
shipping with Intel cards where we will eventually be able do our own
video reinit after suspend, and some with Nvidia chipsets where it
doesn't seem terribly likely until someone at Nvidia has a change of
heart, the BIOS won't be able to use the "please reinit video" as a
general "Linux" indicator, since they will need to support laptops
with Good as well as Evil graphics chipsets.  :-)

     	     	     	  	   	      - Ted
