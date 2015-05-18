From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH] ACPI/sbshc: Add 5us delay to fix SBS hang on MacBook
Date: Mon, 18 May 2015 14:07:39 +0100
Message-ID: <20150518130739.GA2483@localhost>
References: <20150424012530.GA16763@localhost>
 <4435249.leKkNHm9IZ@vostro.rjw.lan>
 <20150429202140.GB25904@localhost>
 <55594C71.9060402@fnarfbargle.com>
 <20150518122737.GA5850@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35958 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbbERNHn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2015 09:07:43 -0400
Received: by wizk4 with SMTP id k4so78563160wiz.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2015 06:07:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150518122737.GA5850@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brad Campbell <brad@fnarfbargle.com>
Cc: linux-acpi@vger.kernel.org

On Mon, May 18, 2015 at 01:27:37PM +0100, Chris Bainbridge wrote:
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 01504c8..74f8596 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -361,16 +361,21 @@ static int acpi_manager_get_info(struct acpi_sbs *sbs)
>  static int acpi_battery_get_info(struct acpi_battery *battery)
>  {
>  	int i, result = 0;
> -
> -	for (i = 0; i < ARRAY_SIZE(info_readers); ++i) {
> -		result = acpi_smbus_read(battery->sbs->hc,
> -					 info_readers[i].mode,
> -					 ACPI_SBS_BATTERY,
> -					 info_readers[i].command,
> -					 (u8 *) battery +
> -						info_readers[i].offset);
> -		if (result)
> -			break;
> +	int j;
> +
> +	for (j = 0; j < 1000; j++) {
> +		for (i = 0; i < ARRAY_SIZE(info_readers); ++i) {
> +			result = acpi_smbus_read(battery->sbs->hc,
> +						 info_readers[i].mode,
> +						 ACPI_SBS_BATTERY,
> +						 info_readers[i].command,
> +						 (u8 *) battery +
> +							info_readers[i].offset);
> +			if (result) {
> +				printk("FAIL\n");
> +				break;
> +			}
> +		}
>  	}
>  	return result;
>  }


Better to exit immediately when SBS hangs, otherwise you could be
waiting a long time for modprobe to return:


diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 01504c8..84f422f 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -361,17 +361,22 @@ static int acpi_manager_get_info(struct acpi_sbs *sbs)
 static int acpi_battery_get_info(struct acpi_battery *battery)
 {
 	int i, result = 0;
-
-	for (i = 0; i < ARRAY_SIZE(info_readers); ++i) {
-		result = acpi_smbus_read(battery->sbs->hc,
-					 info_readers[i].mode,
-					 ACPI_SBS_BATTERY,
-					 info_readers[i].command,
-					 (u8 *) battery +
-						info_readers[i].offset);
-		if (result)
-			break;
+	int j;
+
+	for (j = 0; j < 100; j++) {
+		for (i = 0; i < ARRAY_SIZE(info_readers); ++i) {
+			result = acpi_smbus_read(battery->sbs->hc,
+						 info_readers[i].mode,
+						 ACPI_SBS_BATTERY,
+						 info_readers[i].command,
+						 (u8 *) battery +
+							info_readers[i].offset);
+			if (result)
+				goto end;
+		}
 	}
+      end:
+	printk(result ? "FAIL" : "OK");
 	return result;
 }
 

I'm sure you get the idea. Forcing repeated SBS reads is a much quicker
way to uncover an intermittent fault than through normal usage. After
adding the 5us delay, I was able to run the acpi_battery_get_info loop
for 20,000 cycles without fault, but this is just one Macbook, others
may be different. It's also possible that the delay is just covering up
some other problem; some patches were posted a few days ago to fix some
underlying hang issues: http://www.spinics.net/lists/linux-acpi/msg57572.html
