From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: acpi_battery_add(): use-after-free
Date: Mon, 30 Jul 2007 15:34:20 -0700
Message-ID: <20070730153420.317ae2ee.akpm@linux-foundation.org>
References: <20070729150046.GM16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52703 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932790AbXG3Wev (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jul 2007 18:34:51 -0400
In-Reply-To: <20070729150046.GM16817@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 29 Jul 2007 17:00:46 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> The Coverity checker spotted the following use-after-free in 
> acpi_battery_add():
> 
> <--  snip  -->
> 
> ...
> static int acpi_battery_add(struct acpi_device *device)
> {
> ...
>         if (result) {
>                 acpi_battery_remove_fs(device);
>                 kfree(battery);
>         }
> 
>         mutex_unlock(&battery->mutex);
> ...
> 
> <--  snip  -->
> 

This?

--- a/drivers/acpi/battery.c~acpi_battery_add-use-after-free
+++ a/drivers/acpi/battery.c
@@ -931,13 +931,12 @@ static int acpi_battery_add(struct acpi_
 
       end:
 
+	mutex_unlock(&battery->mutex);
 	if (result) {
 		acpi_battery_remove_fs(device);
 		kfree(battery);
 	}
 
-	mutex_unlock(&battery->mutex);
-
 	return result;
 }
 
_

