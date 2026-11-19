Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062830;
	b=qiAJnEi8NWL+ZoO5kOZ1vpG6F4hmWTmaSFOq5KJAlvU6yIOJisAFrglepfkHJ/4VnEAn
	 NhIgwdarKmSsjL2Epn9MuToRmDN+UAQVV/bLa4yq0A/GZPXDgFK3tY8j2xaQTPC+90lH6
	 GRyasNMwkxu/bp821w5ZPi42ixQJIn9muPr0XGx5cWe5za856+Uk2Oxdg1rrLGYx3i06q
	 axxti4EbwwYQW3lB3iaXgxAy8MxYS+jmQRz5hzjFVt24DKVKNNK7aImrjFV41dYTLUQGs
	 j0qgq/MV8pk0nL1k4UkfqJWrHb4apf7BkBilt3T7ASkIDHwa68wM5A/eu4BXxg0ZO6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062830;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=7TD0Md0mVnFdPLU1Yyiv7w9mu5gUlK6e+evzCk4KI8U=;
	b=oY3W6LyGsWYXtEaheNNa5IbC86Z7CFnvUDeXQABy+q3Fapb5QZYitb2DEZlEpt7WyW+b
	 1Y5S9RfBg7Au0P4BKL58Ewd6koD59cm0pKv3wgCoGhgFoQEfADXS2UkRxfHEnrU57EZii
	 T5DZI1qlterf7aaWZr+z3kiH1aRwy4ndkGo2PI4o8NYP40b+aSBpcewlf7I/vgUBxdNss
	 Uc9FQ0oFTHntqDeQWcUTAoqfN/Nf73m3el355ygEzO2N9GJJFTkLV7J3+eOZbn/kPLm/H
	 i24zNAbpcszmNP9AwfHdSsC3PHqf6C9oUk9t4lx8Hb7UiQTykR+nUkxtbJ8Nl94BPag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376E606A326
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 04:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B376E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-85d630e451aso1955281a34.2
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 20:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795062828; x=1795667628;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TD0Md0mVnFdPLU1Yyiv7w9mu5gUlK6e+evzCk4KI8U=;
        b=okA4UwuyfK5iS2St2jqYsoonxWO8gwuSKzmgWPhzK3FujzUaOEt4ETB0rTlQA5/OHz
         lmV0dr9kM3Y3vo2IkHiBRuolOD+eslN3xRWpO5ik8/31D6vrmqwVqQKkWIL8m4i1aXGw
         VA7zjpJ4hiVtkUZwke9ig0gGoCPM/pV+LB5J5eY0Gq6gxhvyUDbdkOUScG8ghRibH8RI
         hBD1MIXANdp7oPyuUiIiy9O3ynzEZcph8xB1kbLDoUf1XWk5B/T3HGo9q+JYYr8n9o4R
         mzcTcCvGIwHosS5F5Oqf5peipIBbaidzvOXRyHXSojN9qYet9J+XdldMM+FOx40Ncpbj
         cLig==
X-Forwarded-Encrypted: i=1; AL+hErEfsuSda29ymIk08YvNgZh91mPQO2ZI0UMup0nf68FAKrrB5rskehHuLXKgtZf25AA+Lc+GZAxl1+nf@vger.kernel.org
X-Gm-Message-State: APuU4Z9jP0OU18cDM4vGN7XBO6dkh3JG3C9lUygoflKas0AQdf5Z80cH
	TgSl4YyOiGK8FxoqzSD5J1IWBZazv+FUfdHX/qYoLbsKlMOW6UNLPwNo2aXqdHCdvNyUXrofsgk
	47fexo1ar5E4H8Cm2O8WnXyL756UhwKG3c1343Fb0TeST/jSWe4pxB1sqDxE=
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc7:b0:571:9502:8303 with SMTP id
 5614622812f47-5774171cd65mr5660064b6e.50.1795062828749; Wed, 18 Nov 2026
 20:33:48 -0800 (PST)
Date: Wed, 18 Nov 2026 20:33:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afe7c2c.902182b0.170f33.0000.GAE@google.com>
Subject: [syzbot] Monthly acpica report (Nov 2026)
From: syzbot <syzbot+list0ad76eb042dcf70ab97f@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello acpica maintainers/developers,

This is a 31-day syzbot report for the acpica subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/acpica

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 14      Yes   KASAN: slab-use-after-free Read in acpi_ut_update_object_reference
                  https://syzkaller.appspot.com/bug?extid=c6c92a97a9907f92fa1c
<2> 380     Yes   KASAN: use-after-free Read in acpi_ns_get_attached_object
                  https://syzkaller.appspot.com/bug?extid=5725792ce6a9938d1b24
<3> 2       No    KASAN: slab-use-after-free Read in acpi_ns_check_package
                  https://syzkaller.appspot.com/bug?extid=e1268acad3c273b12120

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
