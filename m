From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC, PATCH] acer-wmi: Add driver for newer Acer laptops
Date: Wed, 5 Dec 2007 01:57:49 +0000
Message-ID: <20071205015749.GA8692@srcf.ucam.org>
References: <200712041447.28077.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:60069 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXLEB6A (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 4 Dec 2007 20:58:00 -0500
Content-Disposition: inline
In-Reply-To: <200712041447.28077.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Linux-acpi@vger.kernel.org

On Tue, Dec 04, 2007 at 02:47:27PM +0000, Carlos Corbacho wrote:

> +#define AMW0_GUID1		"67C3371D-95A3-4C37-BB61-DD47B491DAAB"
> +#define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"

It would be nice to export these, so wmi-based drivers could be 
autoloaded.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
