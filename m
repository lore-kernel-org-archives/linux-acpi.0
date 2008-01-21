From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sun, 20 Jan 2008 20:52:38 -0500
Message-ID: <20080121015238.GA8105@mit.edu>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801192313.10296.lenb@kernel.org> <47933886.7050401@dbservice.com> <200801201331.59478.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:53621 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755202AbYAUBxH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 20:53:07 -0500
Content-Disposition: inline
In-Reply-To: <200801201331.59478.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tomas Carnecky <tom@dbservice.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Sun, Jan 20, 2008 at 01:31:59PM -0500, Len Brown wrote:
> We as the Linux community can define "Needs BIOS S3 video restore" as a string
> and ship it in our kernel, telling BIOS writers about it.

Maybe we should define the S3 video strong right away, along with
whatever else Lenovo was trying to use OSI(Linux) for, and then get
the distro's to ship Errata kernels that answer yes for those
questions ASAP.  Then we can work with Laptop vendors to release new
BIOS's that use the new OSI strings instead of Linux, since they can
just tell people that they need to upgrade to the latest Ubuntu/SLES
kernel.

Hopefully, this would allow us to recover from this mess as quickly as
possible.

						- Ted


