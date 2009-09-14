From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 0/3] rfkill_unregister() should always be followed by rfkill_destroy()
Date: Mon, 14 Sep 2009 12:43:50 +0200
Message-ID: <1252925033-29696-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755136AbZINKv2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Johannes Berg <johannes@sipsolutions.net>, Corentin Chary <corentincj@iksaif.net>
List-Id: linux-acpi@vger.kernel.org

The semantic match that finds the first problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>

@r@
expression E;
position p;
@@

rfkill_unregister(E);@p
... when != rfkill_destroy(E)

@script:python@
p << r.p;
@@

print "rfkill_unregister without rfkill_destroy found: %s %s " % (p[0].file, p[0].line)
// </spml>

Corentin Chary (3):
  hp-wmi: fix rfkill memory leak on unload
  thinkpad_acpi: fix rfkill memory leak on unload
  dell-laptop: fix rfkill memory leak on unload

 drivers/platform/x86/dell-laptop.c   |   36 ++++++++++++++++++++++-----------
 drivers/platform/x86/hp-wmi.c        |    2 +-
 drivers/platform/x86/thinkpad_acpi.c |    1 +
 3 files changed, 26 insertions(+), 13 deletions(-)
