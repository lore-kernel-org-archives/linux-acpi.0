From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 57/98] sony-laptop: Add support for extra keyboard events
Date: Sun, 29 Mar 2009 16:03:38 +0100
Message-ID: <20090329150338.GA8500@srcf.ucam.org>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <9b57896e62bfa752ee7435e6cfe57fb210c0db8c.1238214619.git.len.brown@intel.com> <200903291253.05030.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59758 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbZC2PDs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 11:03:48 -0400
Content-Disposition: inline
In-Reply-To: <200903291253.05030.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

On Sun, Mar 29, 2009 at 12:53:04PM +0200, Matthias Welwarsky wrote:
>  	{ 0x90, SONYPI_EVENT_PKEY_P1 },
>  	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
> -	{ 0x91, SONYPI_EVENT_PKEY_P1 },
> +	{ 0x91, SONYPI_EVENT_PKEY_P2 },
>  	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
>  	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
>  	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },

Oops, yes...

> @@ -929,7 +929,7 @@
>  		if (sony_find_snc_handle(0x127) == ev)
>  			key_handle = 0x127;
>  
> -		if (handle) {
> +		if (key_handle) {

Indeed.

> -		}
> +		} else
> +			sony_laptop_report_input_event(ev);

That doesn't look right, though - sony_laptop_report_input_event expects 
a value that matches the input_index array, and an unprocessed event 
>0x90 isn't going to satisfy that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
