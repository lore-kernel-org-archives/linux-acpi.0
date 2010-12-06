From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/7] ACPI video: check cap._DDC flag before getting EDID
Date: Mon, 6 Dec 2010 12:53:40 +0000
Message-ID: <20101206125340.GA20645@srcf.ucam.org>
References: <1291619064.19296.579.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37073 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab0LFMxs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Dec 2010 07:53:48 -0500
Content-Disposition: inline
In-Reply-To: <1291619064.19296.579.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Dec 06, 2010 at 03:04:24PM +0800, Zhang Rui wrote:
> 
> cap._DDC is defined but never used.
> Check this flag now and don't try to get EDID for video output devices with this flag cleared.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
