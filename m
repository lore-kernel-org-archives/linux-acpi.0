From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Thu, 3 Nov 2011 10:16:52 +0100
Message-ID: <201111031016.52676.trenn@suse.de>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110311133.31320.trenn@suse.de> <CAErSpo5X0smhAeoe6b7iEjGWqcZMxjoL82Mk4BqyqZZZp2_Feg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37351 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755605Ab1KCJQz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Nov 2011 05:16:55 -0400
In-Reply-To: <CAErSpo5X0smhAeoe6b7iEjGWqcZMxjoL82Mk4BqyqZZZp2_Feg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Monday, October 31, 2011 04:51:07 PM Bjorn Helgaas wrote:
> On Mon, Oct 31, 2011 at 4:33 AM, Thomas Renninger <trenn@suse.de> wrote:

> Seems like these are BIOS bugs.  Do we know for sure that Windows
> consumes this information that seems to be wrong?  Have you had a
> conversation with the vendor about whether the BIOS is at fault here?
Such closed specifications between a major OS and specific HW vendors
should be forbidden by law and I expect in some countries you'll win
if you contest this contract in a high enough court...
APEI is based on the Windows WHEA specification which only specific
vendors can retrieve from Windows if they sign an NDA contract.
I could imagine there you find details about the GAS structure usage
in WHEA/APEI tables the way Windows like it.

After looking at quite a lot APEI tables and their bit width, byte access
and mask values, I am pretty sure bit width is ignored on Windows.
Or say, if these tables are used, access width is always correct while
bit width is not.
 
> If we make Linux ignore the bit_width, that might "fix" these boxes
> with broken BIOSes, but at the cost of breaking a box that uses
> bit_width correctly.
None of the "broken bit width" boxes I looked at should break if
access width is used.

   Thomas
