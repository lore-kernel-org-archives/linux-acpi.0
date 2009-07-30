From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: bind workqueues to CPU 0 to avoid SMI corruption
Date: Thu, 30 Jul 2009 04:17:35 +0100
Message-ID: <20090730031735.GA1202@srcf.ucam.org>
References: <20090729215425.23674.80263.stgit@bob.kio> <20090730024300.GA30451@sli10-desk.sh.intel.com> <20090730025554.GD26389@srcf.ucam.org> <20090730031348.GA24959@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42916 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbZG3DRi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2009 23:17:38 -0400
Content-Disposition: inline
In-Reply-To: <20090730031348.GA24959@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jul 30, 2009 at 11:13:48AM +0800, Shaohua Li wrote:

> ACPICA isn't designed for performance. If it has performance issue, it should
> already have.

Yeah. My point was just that we have some customers who like tuning 
systems heavily - I suspect they'd prefer to be able to control whether 
or not ACPI is running entirely on cpu 0 or not. As you say, it should 
make little difference in the real world but some people do have very 
specialised requirements.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
