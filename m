From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add EEE Bluetooth ACPI details
Date: Wed, 3 Dec 2008 20:34:29 +0000
Message-ID: <20081203203429.GA24103@srcf.ucam.org>
References: <20081203203111.GA28234@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34393 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbYLCUec (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 15:34:32 -0500
Content-Disposition: inline
In-Reply-To: <20081203203111.GA28234@earth.li>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: corentincj@iksaif.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 03, 2008 at 08:31:11PM +0000, Jonathan McDowell wrote:
> Although rfkill support for the EEE bluetooth device has been added to
> 2.6.28-rc the appropriate ACPI accessor definitions were not added, so
> the support was non functional. The patch below adds the get and set
> accessors and has been verified to work on an EEE 901.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
