From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [patch 05/12] fujitsu-laptop: fix tests of acpi_evaluate_integer()
Date: Wed, 25 Nov 2009 12:11:03 +0100
Message-ID: <4B0D10C7.6080603@gmail.com>
References: <200911250629.nAP6TL2u009406@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:60229 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbZKYLK6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 06:10:58 -0500
Received: by fg-out-1718.google.com with SMTP id d23so3047921fga.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2009 03:11:02 -0800 (PST)
In-Reply-To: <200911250629.nAP6TL2u009406@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org

The wrong test was used, acpi_status status is unsigned. Callers
expect an -errno on failure.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
>>> The wrong test was used acpi_status status is unsigned.

>>> -	if (status < 0)
>>> +	if (ACPI_FAILURE(status))
>>>  		return status;
>>
>> as status is a positive number, shouldn't we be returning something like 
>> -1 here on failure, rather than status?
> 
> These functions are called via the backlight_ops structure by the standard
> backlight class framework and it seems, from a real quick look, that the API
> treats numbers >=0 as valid data.  So something like this (untested, off the
> top of my head) might be more appropriate:

>  	status =
>  	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
> -	if (status < 0)
> -		return status;
> +	if (ACPI_FAILURE(status))
> +		return -status;

> Otherwise "return -1;" would be fine by me.  My only reason for going with
> "-status" is that it might give some clue as to what went wrong.  Thoughts?

The acpi errors have an entirely different range, won't that confuse the
caller? Maybe it's better to return an -errno and display the acpi error in
a warning message.

Also, acpi_fujitsu_add() and acpi_fujitsu_notify() ignore a get_lcd_level()
error return. Is that ok?

e.g. something like:

 drivers/platform/x86/fujitsu-laptop.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index bcd4ba8..714c472 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -376,8 +376,10 @@ static int get_lcd_level(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
-	if (status < 0)
-		return status;
+	if (ACPI_FAILURE(status)) {
+		pr_warning("%s failed, acpi error: %u\n", __func__, status);
+		return -EINVAL;
+	}
 
 	fujitsu->brightness_level = state & 0x0fffffff;
 
@@ -398,8 +400,10 @@ static int get_max_brightness(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
-	if (status < 0)
-		return status;
+	if (ACPI_FAILURE(status)) {
+		pr_warning("%s failed, acpi error: %u\n", __func__, status);
+		return -EINVAL;
+	}
 
 	fujitsu->max_brightness = state;
 

