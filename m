From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [regression] hp-wmi: hangs system on boot
Date: Fri, 16 Jan 2009 18:52:40 -0600
Message-ID: <49712BD8.6060603@lwfinger.net>
References: <200901170013.55786.elendil@planet.nl> <200901170131.22541.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765453AbZAQAxA@vger.kernel.org>
In-Reply-To: <200901170131.22541.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Frans Pop wrote:
> On Saturday 17 January 2009, Frans Pop wrote:
>> When I first booted .29-rc2 my HP 2510p notebook hung while loading
>> hp-wmi, which I have listed in /etc/modules. Hard poweroff was needed.
> 
> Reverting the following commit fixes the problems:
> 
> commit fe8e4e039dc3680681bf51af097af391f87038f8
> Author: Larry Finger <Larry.Finger@lwfinger.net>
> Date:   Fri Jan 9 16:40:54 2009 -0800
> 
>     hp-wmi: handle rfkill_register() failure

Ooops. There was a missing if statement. This one should fix it.


Index: linux-2.6/drivers/platform/x86/hp-wmi.c
===================================================================
--- linux-2.6.orig/drivers/platform/x86/hp-wmi.c
+++ linux-2.6/drivers/platform/x86/hp-wmi.c
@@ -441,6 +441,7 @@ static int __init hp_wmi_bios_setup(stru
 		bluetooth_rfkill->toggle_radio = hp_wmi_bluetooth_set;
 		bluetooth_rfkill->user_claim_unsupported = 1;
 		err = rfkill_register(bluetooth_rfkill);
+		if (err)
 			goto register_bluetooth_error;
 	}


-------
