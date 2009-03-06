From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 6 Mar 2009 18:53:40 +0000
Message-ID: <20090306185340.GA14507@srcf.ucam.org>
References: <20090306005234.GA32539@srcf.ucam.org> <1236330536.12838.2.camel@hughsie-work.lan> <1236332843.19146.4.camel@petitemort> <20090306095623.GA6014@srcf.ucam.org> <1236333861.19146.9.camel@petitemort> <20090306100951.GA6268@srcf.ucam.org> <1236334376.19146.11.camel@petitemort> <20090306101533.GA6408@srcf.ucam.org> <1236334909.19146.16.camel@petitemort> <E1Lff74-000Hwq-00.arvidjaar-mail-ru@mx2.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46673 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbZCFSxu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2009 13:53:50 -0500
Content-Disposition: inline
In-Reply-To: <E1Lff74-000Hwq-00.arvidjaar-mail-ru@mx2.mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: dsilvers@simtec.co.uk, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 06, 2009 at 09:49:36PM +0300, Andrey Borzenkov wrote:

> There are two ways to control fan here - standard ACPI and HCI. ACPI does 
> not work. Is there any standard framework for fan control (a la 
> power_supply) where HCI version could be plugged in?

Yes, it could be hooked into the thermal or hwmon layers. Thermal is 
probably best - it'll then automatically be exported as an hwmon device 
as well.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
