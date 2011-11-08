From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH -v2 0/4] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Tue, 8 Nov 2011 02:00:36 +0100
Message-ID: <201111080200.37577.trenn@suse.de>
References: <20111107232321.13472.52069.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54069 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab1KHBAk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Nov 2011 20:00:40 -0500
In-Reply-To: <20111107232321.13472.52069.stgit@amt.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Myron Stowe <myron.stowe@redhat.com>, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com, bhelgaas@google.com, linux-kernel@vger.kernel.org

Len: If these could still make it into 3.2, that would allow
consideration of access width for APEI GAR structures
which are needed for some BIOSes in an easy way.

These would be the one or other small patch which shouldn't
be a big issue to add later, but without these it gets ugly...

Thanks,

   Thomas
