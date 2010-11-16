From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH]  do not select ACPI_VIDEO in poulsbo stub driver
Date: Tue, 16 Nov 2010 14:11:05 +0000
Message-ID: <20101116141105.GA13582@srcf.ucam.org>
References: <1289887493.8148.2040.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58659 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab0KPOLP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2010 09:11:15 -0500
Content-Disposition: inline
In-Reply-To: <1289887493.8148.2040.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joey Lee <jlee@novell.com>, mingo@elte.hu, airlied@redhat.com, "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Nov 16, 2010 at 02:04:53PM +0800, Zhang Rui wrote:
> 
> the poulsbo stub driver should not select ACPI video driver.

No, the entire point is for the driver to make this call.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
