From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60 (bisected)
Date: Tue, 12 Aug 2008 20:30:04 +0200
Message-ID: <20080812183004.GA24211@isilmar.linta.de>
References: <20080806090246.GA1572@elf.ucw.cz> <48A1779B.5020303@redhat.com> <20080812115530.GB8806@elf.ucw.cz> <200808121634.34634.rjw@sisk.pl> <48A1A4F6.9080706@redhat.com> <48A1B0CB.9050908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:49642 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752006AbYHLSaI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Aug 2008 14:30:08 -0400
Content-Disposition: inline
In-Reply-To: <48A1B0CB.9050908@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Milan Broz <mbroz@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Renninger <trenn@suse.de>

Hi,

On Tue, Aug 12, 2008 at 05:48:27PM +0200, Milan Broz wrote:
> -static unsigned int ignore_ppc = -1;
> +static int ignore_ppc = -1;
>  module_param(ignore_ppc, uint, 0644);
			    ^^^^
follow-up change?

Best,
	Dominik
