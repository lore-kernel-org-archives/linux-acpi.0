From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Mon, 21 Jan 2008 09:50:00 +0000
Message-ID: <20080121095000.GA2785@srcf.ucam.org>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801192313.10296.lenb@kernel.org> <47933886.7050401@dbservice.com> <200801201331.59478.lenb@kernel.org> <20080121015238.GA8105@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:59784 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758530AbYAUJ5e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 04:57:34 -0500
Content-Disposition: inline
In-Reply-To: <20080121015238.GA8105@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
Cc: Len Brown <lenb@kernel.org>, Tomas Carnecky <tom@dbservice.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Sun, Jan 20, 2008 at 08:52:38PM -0500, Theodore Tso wrote:

> Maybe we should define the S3 video strong right away, along with
> whatever else Lenovo was trying to use OSI(Linux) for, and then get
> the distro's to ship Errata kernels that answer yes for those
> questions ASAP.  

I'd prefer to figure out what they're actually doing with it, since 
clearly Windows doesn't need this. I'm not especially comfortable with 
the S3 video stuff, but it seems safer - I just strongly suspect that 
giving vendors a "Please reinitialise video when exiting S3" option will 
be abused as a general "Linux" indicator.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
