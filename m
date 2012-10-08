From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [bisected] PS/2 keyboard and mouse dead on resume on Intel
 D845BG
Date: Mon, 8 Oct 2012 15:42:43 +0100
Message-ID: <20121008144243.GC5068@srcf.ucam.org>
References: <201210071513.27959.linux@rainbow-software.org>
 <201210072100.09813.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45831 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab2JHOnW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Oct 2012 10:43:22 -0400
Content-Disposition: inline
In-Reply-To: <201210072100.09813.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, Oct 07, 2012 at 09:00:09PM +0200, Ondrej Zary wrote:

> Added acpi_read_bit_register there and it seems that SCI_EN is already set!
> 
> This patch fixes the problem here. I wonder how this affects systems that
> require SCI_EN to be set.

I /think/ that this will be safe, but it doesn't match my recollection 
of how Windows behaves so it may break something. Any chance you can 
find someone with one of the machines mentioned in 
https://bugzilla.kernel.org/show_bug.cgi?id=13745 and make sure that 
they still work with your patch?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
