From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 16/16] ACPI: add DMI entry to work around another
	insane Toshiba BIOS
Date: Wed, 29 Sep 2010 16:48:30 +0100
Message-ID: <20100929154830.GA24577@srcf.ucam.org>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com> <b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38742 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab0I2Psi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 11:48:38 -0400
Content-Disposition: inline
In-Reply-To: <b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Tue, Sep 28, 2010 at 11:44:46PM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Toshiba Satellite C655D-S5048

Why are we not making this the default behaviour, perhaps with a boot or 
config option to disable it if people really can't live with the memory 
hit?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
