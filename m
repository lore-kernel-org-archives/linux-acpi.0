From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/7] x86 platform drivers: hp-wmi Add media key 0x20e8
Date: Fri, 21 May 2010 16:18:12 +0200
Message-ID: <1274451495-10252-5-git-send-email-trenn@suse.de>
References: <1274451495-10252-1-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1274451495-10252-1-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg@redhat.com, trenn@suse.de
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: mjg@redhat.com
CC: linux-acpi@vger.kernel.org
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/hp-wmi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index e04715a..f3ae911 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -96,6 +96,7 @@ static struct key_entry hp_wmi_keymap[] = {
 	{KE_KEY, 0x02, KEY_BRIGHTNESSUP},
 	{KE_KEY, 0x03, KEY_BRIGHTNESSDOWN},
 	{KE_KEY, 0x20e6, KEY_PROG1},
+	{KE_KEY, 0x20e8, KEY_MEDIA},
 	{KE_KEY, 0x2142, KEY_MEDIA},
 	{KE_KEY, 0x213b, KEY_INFO},
 	{KE_KEY, 0x2169, KEY_DIRECTION},
-- 
1.6.3

