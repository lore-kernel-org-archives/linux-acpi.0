From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 09/19] eeepc-laptop: support for super hybrid engine (SHE)
Date: Mon, 25 May 2009 10:12:31 +0200
Message-ID: <200905251012.31526.corentin.chary@gmail.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com> <71cd59b00905241023h6ecfa13axc2dc82863053cdc1@mail.gmail.com> <4A198401.3040003@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:51847 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZEYIN4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 May 2009 04:13:56 -0400
Received: by fg-out-1718.google.com with SMTP id d23so596435fga.17
        for <linux-acpi@vger.kernel.org>; Mon, 25 May 2009 01:13:56 -0700 (PDT)
In-Reply-To: <4A198401.3040003@tuffmail.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Grigori Goronzy <greg@chown.ath.cx>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sunday 24 May 2009 19:29:37 Alan Jenkins wrote:
> Corentin Chary wrote:
> > On Sun, May 24, 2009 at 11:28 AM, Alan Jenkins
> >
> > <sourcejedi.lkml@googlemail.com> wrote:
> >> On 5/16/09, Len Brown <lenb@kernel.org> wrote:
> >>> From: Grigori Goronzy <greg@chown.ath.cx>
> >>>
> >>> The older eeepc-acpi driver allowed to control the SHE performance
> >>> preset through a ACPI function for just this purpose. SHE underclocks
> >>> and undervolts the FSB and undervolts the CPU (at preset 2,
> >>> "powersave"), or slightly overclocks the CPU (at preset 0,
> >>> "performance"). Preset 1 is the default setting with default clocks and
> >>> voltage.
> >>>
> >>> The new eeepc-laptop driver doesn't support it anymore.
> >>> The attached patch adds support for it to eeepc-laptop. It's very
> >>> straight-forward and almost trivial.
> >>>
> >>> Signed-off-by: Grigori Goronzy <greg@chown.ath.cx>
> >>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> >>> Signed-off-by: Len Brown <len.brown@intel.com>
> >>> ---
> >>
> >> Hi, out of curiosity I tried this on my EeePC 701.  I upgraded the
> >> BIOS to the latest version available a few months ago.
> >>
> >> I find that the file is present and can successfully be read from.
> >> The file returns the value "513".  If I write "1" to it, nothing
> >> happens.  If I write "0" to it, the speakers start hissing and the
> >> file then returns the value "512".  Writing "1" again gets it back to
> >> normal.  There is no apparent effect on performance.
> >>
> >> This is stupid, because we _do_ appear to check the BIOS supported
> >> features bitmask, but that's Asus firmware for you.  Can you please
> >> add an extra test, so this file only allows  reads or writes if the
> >> current value is 0 or 1?  If you're quick you might slip it into -rc8

Hi, Can you try this patch ? It seems to works for me.

>From c357105fe0016f71d92d7a11500d7cd72b70282f Mon Sep 17 00:00:00 2001
From: Corentin Chary <corentincj@iksaif.net>
Date: Mon, 25 May 2009 10:08:00 +0200
Subject: [PATCH 3/3] eeepc-laptop: Fix cpufv

Limit cpufv input to acceptable values.
Make cpufv output more readable.

According to the dsdt, the value returned by CFVG
is composed by the current setting in the first byte
and the number of settings (starting from 0) in the
second byte.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   59 ++++++++++++++++++++++++++++++++++-
 1 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index a0845b2..4e1cf2d 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -395,7 +395,64 @@ static ssize_t show_sys_acpi(int cm, char *buf)
 EEEPC_CREATE_DEVICE_ATTR(camera, CM_ASL_CAMERA);
 EEEPC_CREATE_DEVICE_ATTR(cardr, CM_ASL_CARDREADER);
 EEEPC_CREATE_DEVICE_ATTR(disp, CM_ASL_DISPLAYSWITCH);
-EEEPC_CREATE_DEVICE_ATTR(cpufv, CM_ASL_CPUFV);
+
+struct eeepc_cpufv
+{
+	int num;
+	int cur;
+};
+
+static int get_cpufv(struct eeepc_cpufv *c)
+{
+	c->cur = get_acpi(CM_ASL_CPUFV);
+	c->num = (c->cur >> 8) & 0xff;
+	c->cur &= 0xff;
+	if (c->cur < 0 || c->num <= 0 || c->num > 12)
+		return -ENODEV;
+	return 0;
+}
+
+static ssize_t show_cpufv(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct eeepc_cpufv c;
+	int i;
+	ssize_t len = 0;
+
+	if (get_cpufv(&c))
+		return sprintf(buf, "<unsupported>\n");
+	for (i = 0; i < c.num; i++)
+		len += sprintf(buf + len, "%d%s ", i, i == c.cur ? "*" : "");
+	len += sprintf(buf + len, "\n");
+	return len;
+}
+
+static ssize_t store_cpufv(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct eeepc_cpufv c;
+	int rv, value;
+
+	if (get_cpufv(&c))
+		return -ENODEV;
+	rv = parse_arg(buf, count, &value);
+	if (rv < 0)
+		return rv;
+	if (!rv || value < 0 || value >= c.num)
+		return -EINVAL;
+	set_acpi(CM_ASL_CPUFV, value);
+	return rv;
+}
+
+static struct device_attribute dev_attr_cpufv = {
+	.attr = {
+		.name = "cpufv",
+		.mode = 0644 },
+	.show   = show_cpufv,
+	.store  = store_cpufv
+};
 
 static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
-- 
1.6.3.1


