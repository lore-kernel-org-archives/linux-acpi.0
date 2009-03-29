From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 57/98] sony-laptop: Add support for extra keyboard events
Date: Sun, 29 Mar 2009 18:13:45 +0100
Message-ID: <20090329171345.GA10131@srcf.ucam.org>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <200903291838.14723.matze@welwarsky.de> <20090329164107.GA9566@srcf.ucam.org> <200903291908.36826.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36040 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbZC2RNu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 13:13:50 -0400
Content-Disposition: inline
In-Reply-To: <200903291908.36826.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

On Sun, Mar 29, 2009 at 07:08:36PM +0200, Matthias Welwarsky wrote:
> +			} else
> +				sony_laptop_report_input_event(ev);
>  		} else if (sony_find_snc_handle(0x124) == ev) {
>  			sony_nc_rfkill_update();
>  			return;

Nitpicky, but with this codeflow I think we can skip the return there?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
