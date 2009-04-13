From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 1/2] toshiba-acpi: Add support for hotkey notifications
Date: Mon, 13 Apr 2009 22:38:09 +0200
Message-ID: <200904132238.11401.elendil@planet.nl>
References: <20090331214501.GC29489@srcf.ucam.org> <200904132128.54769.elendil@planet.nl> <20090413194341.GA16579@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml106.kpnxchange.com ([195.121.3.10]:61787 "EHLO
	CPSMTPM-EML106.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522AbZDMUiO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 16:38:14 -0400
In-Reply-To: <20090413194341.GA16579@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, lenb@intel.com

On Monday 13 April 2009, Matthew Garrett wrote:
> Hm. Do you get events for the multimedia keys without this patch and
> using the old interface?

Yes, 2.6.28 gives in /proc/acpi/toshiba/keys as value for 'hotkey':
previous track:	0x0b31
next track:	0x0b32
play/pause:	0x0b33
stop:		0x0b30

And fnfx-client in debug mode shows the four keys as well.
