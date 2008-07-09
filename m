From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [RFC PATCH 2/4] ACPI: introduce the mechanism to
	save/restore ACPI NVS memory
Date: Thu, 10 Jul 2008 00:44:58 +0200
Message-ID: <20080709224457.GA5629@elf.ucw.cz>
References: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com> <20080708193558.GC8694@ucw.cz> <20080709145850.GA18230@khazad-dum.debian.net> <200807092226.12195.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46595 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYGIWoE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2008 18:44:04 -0400
Content-Disposition: inline
In-Reply-To: <200807092226.12195.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@zh-kernel.org>


> However, speaking of vendors, I'd like us to be able to switch that off using
> an 'acpi_sleep=' option (s4_no_nvs comes to mind) and/or blacklist broken
> BIOSes.

Works for me. (Plus, shutdown mode will not do any ACPI NVS saving, right?)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
