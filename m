From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: Export EDID blocks to the kernel
Date: Tue, 30 Mar 2010 17:49:47 +0100
Message-ID: <20100330164947.GA27983@srcf.ucam.org>
References: <1263323823-11847-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38815 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab0C3Qtt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2010 12:49:49 -0400
Content-Disposition: inline
In-Reply-To: <1263323823-11847-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

On Tue, Jan 12, 2010 at 02:17:03PM -0500, Matthew Garrett wrote:
> The ACPI spec includes a provision for hardware to provide EDID via the
> ACPI video extension. In the KMS world it's necessary for a way to obtain
> this from within the kernel. Add a function that either returns the EDID
> for the provided ACPI display ID or the first display of the provided type.
> Also add support for ensuring that devices with legacy IDs are supported.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Did this get picked up?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
