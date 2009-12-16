From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [REGRESSION] 9a884ab64a4d092b4c3bf24fd9a30f7fbd4591e7 causes
	boot hang
Date: Wed, 16 Dec 2009 15:10:58 +0000
Message-ID: <20091216151058.GB15217@srcf.ucam.org>
References: <20091215181538.GA28707@srcf.ucam.org> <1260925040.3834.69.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38594 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762208AbZLPPLH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 10:11:07 -0500
Content-Disposition: inline
In-Reply-To: <1260925040.3834.69.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 16, 2009 at 08:57:20AM +0800, Lin Ming wrote:

> Could you try the attached ACPICA latest release (20091214) patch
> series? There are module level code and _REG method fixes included in
> it.

Yes, that appears to fix it. Len, could you push these ASAP?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
