From: Anisse Astier <anisse@astier.eu>
Subject: Re: ACPI & driver patches for 2.6.33-rc2
Date: Thu, 31 Dec 2009 16:41:33 +0100
Message-ID: <20091231164133.3a6831d9@destiny.ordissimo>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:15942 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbZLaPqE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Dec 2009 10:46:04 -0500
Received: by ey-out-2122.google.com with SMTP id 25so1965224eya.19
        for <linux-acpi@vger.kernel.org>; Thu, 31 Dec 2009 07:46:03 -0800 (PST)
In-Reply-To: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len,

On Wed, 30 Dec 2009 02:36:23 -0500, Len Brown <lenb@kernel.org> wrote :

> This batch of patches are queued for 2.6.33-rc2
> Please let me know if you have any troubles with any of them.
> 
> thanks,
> -Len Brown, Intel Open Source Technology Center
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

It's in no rush, but something needs to be done about this regression: 
http://bugzilla.kernel.org/show_bug.cgi?id=14890 , which is either take
the attached patch or revert the offending commit (what you did earlier in
acpi/test and acpi/release before dropping 
d11e073ee3e3091d9190dace97ce480e960cca1b). I'd prefer the taking the patch.

BTW, I screwed up for this, since I didn't see read Thomas' patch which was
sent earlier and did the same thing (except better). The kfree in dell-wmi.c
should still be safe.

Happy Holidays,

Anisse

From: Anisse Astier <anisse@astier.eu>
Date: Mon, 28 Dec 2009 10:27:30 +0100
Subject: [PATCH] hp-wmi: remove double free

Commit 3e9b988e4edf065d39c1343937f717319b1c1065 had the same purpose as commit
44ef00e6482e755f36629773abc2aee83a6f53e3 .
This should solve this regression:
http://bugzilla.kernel.org/show_bug.cgi?id=14890

Signed-off-by: Anisse Astier <anisse@astier.eu>
Reported-by: Sedat Dilek <sedat.dilek@googlemail.com>

---
 drivers/platform/x86/hp-wmi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 8781d8f..222ab57 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -388,8 +388,6 @@ static void hp_wmi_notify(u32 value, void *context)
 	} else
 		printk(KERN_INFO "HP WMI: Unknown key pressed - %x\n",
 			eventcode);
-
-	kfree(obj);
 }
 
 static int __init hp_wmi_input_setup(void)
-- 
1.6.5.7

