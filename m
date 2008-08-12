From: Andi Kleen <andi@firstfloor.org>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60 (bisected)
Date: Tue, 12 Aug 2008 18:28:18 +0200
Message-ID: <20080812162818.GD1366@one.firstfloor.org>
References: <20080806090246.GA1572@elf.ucw.cz> <48A1779B.5020303@redhat.com> <20080812115530.GB8806@elf.ucw.cz> <200808121634.34634.rjw@sisk.pl> <48A1A4F6.9080706@redhat.com> <48A1B0CB.9050908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:44751 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYHLQ1G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Aug 2008 12:27:06 -0400
Content-Disposition: inline
In-Reply-To: <48A1B0CB.9050908@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Milan Broz <mbroz@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Renninger <trenn@suse.de>

> and this seems to fix it for me:

Great. Thanks for the patch. I wonder why gcc didn't warn about this.

-Andi

