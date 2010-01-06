From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: TV_out with toshiba acpi_extras
Date: Wed, 6 Jan 2010 14:39:31 +0000
Message-ID: <20100106143931.GC13984@srcf.ucam.org>
References: <39648cc21001041923o5aea8cf8k2e723fd44477f031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51137 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235Ab0AFOji (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 09:39:38 -0500
Content-Disposition: inline
In-Reply-To: <39648cc21001041923o5aea8cf8k2e723fd44477f031@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Neil Sikka <neilsikka@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Jan 04, 2010 at 10:23:29PM -0500, Neil Sikka wrote:
> Hello. I am trying to get the different display modes working with my
> portege M400 laptop. Im running 2.6.32 with the toshiba_acpi module.
> the problem is that when i do:
> 
> echo "lcd_out:0;crt_out:1" > /proc/acpi/toshiba/video
> cat /proc/acpi/toshiba/video
> 
> i get:
> lcd_out: 1
> crt_out: 0
> tv_out: 0

Using the BIOS to control video outputs is unlikely to work well on any 
hardware produced since 2000 or so. It should be controllable via 
xrandr.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
