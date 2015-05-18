From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH] ACPI/sbshc: Add 5us delay to fix SBS hang on MacBook
Date: Mon, 18 May 2015 13:27:37 +0100
Message-ID: <20150518122737.GA5850@localhost>
References: <20150424012530.GA16763@localhost>
 <4435249.leKkNHm9IZ@vostro.rjw.lan>
 <20150429202140.GB25904@localhost>
 <55594C71.9060402@fnarfbargle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35259 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbbERM1n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2015 08:27:43 -0400
Received: by wgfl8 with SMTP id l8so34374969wgf.2
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2015 05:27:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55594C71.9060402@fnarfbargle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brad Campbell <brad@fnarfbargle.com>
Cc: linux-acpi@vger.kernel.org

On Mon, May 18, 2015 at 10:20:33AM +0800, Brad Campbell wrote:
> On 30/04/15 04:21, Chris Bainbridge wrote:
> >
> >Supporting _OSI("Darwin") caused the MacBook firmware to expose the SBS,
> >resulting in intermittent hangs of several minutes on boot, and failure
> >to detect or report the battery. Fix this by adding a 5us delay to the
> >start of each SMBUS transaction. This timing is the result of
> >experimentation - hangs were observed with 3us but never with 5us.
> 
> G'day Chris,
> 
> Using 4.1-rc3 (whatever git head was from a couple of days ago) I've still
> been seeing ACPI lockups on my Macbook Pro (11,1). It appears to take a
> couple of suspend/resume cycles but seems to happen within 24 hours of
> booting whereas before this patch it was easy to hit.
> 
> As a test (and I do wonder if it'll lock up after I press send on this
> E-mail) I upped the delay to 10us and I've now been up for 1 day, 17:23 with
> the battery still responding to polling.
> 
> To make it easier to reproduce, I've been running a script that polls the
> battery every 60 seconds.
> 
> I figure I'll let it go for another couple of days, but I wanted to put this
> out there in case anyone else is seeing lockups after a longer period of
> uptime. The symptoms are the ACPI command just hangs as does 'cat
> /sys/class/power_supply/BAT0/status'. From there I can't suspend as the
> tasks can't be frozen and I just end up hard booting the machine.
> 
> I've removed Len & Rafael from the cc.
> 
> Regards,
> Brad

I used a patch similar to the following to test, it just runs the SBS
read in a loop. acpi_battery_get_info is run when the sbs module is
loaded. So start off with the 5us delay and a few runs through the loop
and verify you hit the hang, then increase the delay to 10us or whatever
and run the loop for a few thousand cycles until you're happy that
increasing the delay fixes the problem.


diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 01504c8..74f8596 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -361,16 +361,21 @@ static int acpi_manager_get_info(struct acpi_sbs *sbs)
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
+	for (j = 0; j < 1000; j++) {
+		for (i = 0; i < ARRAY_SIZE(info_readers); ++i) {
+			result = acpi_smbus_read(battery->sbs->hc,
+						 info_readers[i].mode,
+						 ACPI_SBS_BATTERY,
+						 info_readers[i].command,
+						 (u8 *) battery +
+							info_readers[i].offset);
+			if (result) {
+				printk("FAIL\n");
+				break;
+			}
+		}
 	}
 	return result;
 }
