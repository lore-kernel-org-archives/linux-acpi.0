From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/7] x86 platform drivers: hp-wmi Catch and log unkown event and key codes correctly
Date: Fri, 21 May 2010 16:18:10 +0200
Message-ID: <1274451495-10252-3-git-send-email-trenn@suse.de>
References: <1274451495-10252-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43663 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755579Ab0EUOSU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 May 2010 10:18:20 -0400
In-Reply-To: <1274451495-10252-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg@redhat.com, trenn@suse.de
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: mjg@redhat.com
CC: linux-acpi@vger.kernel.org
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/hp-wmi.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index f1c1862..7b086dd 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -386,7 +386,9 @@ static void hp_wmi_notify(u32 value, void *context)
 				input_sync(hp_wmi_input_dev);
 				break;
 			}
-		}
+		} else
+			printk(KERN_INFO "HP WMI: Unknown key code - 0x%x\n",
+			       key_code);
 		break;
 	case HPWMI_WIRELESS:
 		if (wifi_rfkill)
@@ -403,8 +405,8 @@ static void hp_wmi_notify(u32 value, void *context)
 					  hp_wmi_get_hw_state(HPWMI_WWAN));
 		break;
 	default:
-		printk(KERN_INFO "HP WMI: Unknown key pressed - %x\n",
-			eventcode);
+		printk(KERN_INFO "HP WMI: Unknown eventcode - %d\n",
+		       eventcode);
 		break;
 	}
 }
-- 
1.6.3

