From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/22] acpi4asus sync with 0.31
Date: Wed, 20 Dec 2006 02:42:24 -0500
Message-ID: <200612200242.24745.lenb@kernel.org>
References: <200612192217.43660.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59073 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbWLTHnE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 02:43:04 -0500
In-Reply-To: <200612192217.43660.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org

On Tuesday 19 December 2006 16:17, Corentin CHARY wrote:
> Hi,
> This set of patch is against 2.6.19. It add support for many 
> models, /sys/class/backlight/, Light Sens, etc ... There is also a lot of 
> cleanups. And the most important, a new system to handle unsupported models.
> 
> Patch from 0 to 10 are change and cleanups in the driver.
> Patch from 11t to 21 add support for new models.
> 
> All the following patchs are available here : 
> <http://xf.iksaif.net/acpi4asus/2.6.19/>

Great!

When this series is formatted to apply, what tree is it supposed to apply to?

How does it relate to the two asus_acpi patches in the mm tree right now --
13/19 and 19/19 that akpm forwarded to the list yesterday.

How does it relate to the acpi-test tree, which already includes
the backlight patch to asus_acpi from Holger Macht?

thanks
-Len

