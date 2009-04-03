From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ACPI: add "auto" to acpi_enforce_resources
Date: Fri, 3 Apr 2009 11:40:11 +0200
Message-ID: <20090403114011.2ab21051@hyperion.delvare>
References: <20090204142015.GB3923@srcf.ucam.org>
	<20090210145716.105ab58b@hyperion.delvare>
	<20090210140829.GA25397@srcf.ucam.org>
	<49919E08.5050002@redhat.com>
	<20090210172408.400cacee@hyperion.delvare>
	<20090227132740.GF1482@ucw.cz>
	<68676e00903240539i119b6d26j516ee131d4cd6781@mail.gmail.com>
	<49C8DE51.2010103@redhat.com>
	<20090329201617.GA10303@dreamland.darkstar.lan>
	<20090329225501.0c1771f1@hyperion.delvare>
	<20090329220127.GA12822@dreamland.darkstar.lan>
	<alpine.LFD.2.00.0904021858460.9182@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:12362 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbZDCJkl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 05:40:41 -0400
In-Reply-To: <alpine.LFD.2.00.0904021858460.9182@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On Thu, 02 Apr 2009 18:59:11 -0400 (EDT), Len Brown wrote:
> From 7e90560c50f754d65884e251e94c1efa2a4b5784 Mon Sep 17 00:00:00 2001
> From: Luca Tettamanti <kronos.it@gmail.com>
> Date: Mon, 30 Mar 2009 00:01:27 +0200
> Subject: [PATCH] ACPI: acpi_enforce_resource=strict by default
> X-Patchwork-Hint: ignore
> 
> Enforce strict resource checking - disallowing access by native
> drivers to IO ports and memory regions claimed by ACPI firmware.
> 
> The patch is mainly aimed to block native hwmon drivers from touching
> monitoring chips that ACPI thinks it own.
> 
> If this causes a regression, boot with "acpi_enforce_resources=lax"
> which was the previous default.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=12376
> http://bugzilla.kernel.org/show_bug.cgi?id=12541
> 
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> Acked-by: Pavel Machek <pavel@suse.cz>
> Acked-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> 
> as applied.

Thanks Len! I'll look into pushing Luca's atk0110 driver upstream later
today (but it's a busy day at work...)

-- 
Jean Delvare
