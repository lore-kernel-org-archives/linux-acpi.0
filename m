From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 16/16] ACPI: add DMI entry to work around another
	insane Toshiba BIOS
Date: Wed, 29 Sep 2010 18:32:45 +0100
Message-ID: <20100929173245.GA26718@srcf.ucam.org>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com> <b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com> <20100929154830.GA24577@srcf.ucam.org> <alpine.LFD.2.00.1009291320180.6673@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58367 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab0I2Rct (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 13:32:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1009291320180.6673@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wed, Sep 29, 2010 at 01:27:23PM -0400, Len Brown wrote:

> It looks like only Toshiba Satellite have this flaw.

If the Leading Other OS is liberal in what it accepts, we're leaving 
ourselves open to reduced compatibility if someone else ends up making 
the same mistake. The hit looks to be around 300K or less.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
