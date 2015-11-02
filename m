From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RFC PATCH] ACPI: Fix build errors due objects compiled
 unconditionally
Date: Mon, 2 Nov 2015 17:19:17 +0100
Message-ID: <56378D05.3030602@osg.samsung.com>
References: <1444692990-10107-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54204 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbbKBQTX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Nov 2015 11:19:23 -0500
In-Reply-To: <1444692990-10107-1-git-send-email-javier@osg.samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hello,

On 10/13/2015 01:36 AM, Javier Martinez Canillas wrote:
> If the CONFIG_ACPI Kconfig symbol is not enabled and a partial build is
> attempted (make M=drivers/acpi), compile errors will happen due missing
> types and identifiers.
> 
> This is because objects are tried to be built unconditionally even when
> CONFIG_ACPI is not enabled. This is usually not a problem since arches'
> Kconfig sources drivers/acpi/Kconfig directly and also selects ACPI but
> the Makefile should conditionally build the objects as well.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Any comments about this patch?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
