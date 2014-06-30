From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: power off problem in Dell 15-7537
Date: Mon, 30 Jun 2014 11:06:33 +0800
Message-ID: <CAOLK0pzpFVrsyTKi258vvWVaZ1LwWy-dDheQv6dyF8Yf=Lu6HA@mail.gmail.com>
References: <53AD6DB2.2040301@soulik.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:39390 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbaF3DGe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jun 2014 23:06:34 -0400
Received: by mail-qc0-f169.google.com with SMTP id c9so6543619qcz.14
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jun 2014 20:06:33 -0700 (PDT)
In-Reply-To: <53AD6DB2.2040301@soulik.info>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ayaka <ayaka@soulik.info>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

2014-06-27 21:12 GMT+08:00 ayaka <ayaka@soulik.info>:
> I have a Dell 15-7537 laptop install fedora 20 with kernel 3.14.8. But I
> can't power off my laptop using systemctl poweroff, I have tried openrc
> in gentoo, it couldn't either. Once I let systemctl power off my laptop,
> it will, but it actually do the reboot, I have to press power button on
> laptop or type halt in grub2, but it will cause the other reboot, after
> the second reboot, I could power off my laptop this time. But in the
> Windows 8.1, I don't need to do that, just click power off it would
> power off my laptop properly.

Hi:
        Could you apply a bug on the kernel bugzilla under product
"ACPI" and component "power-off"?

https://bugzilla.kernel.org




>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards
Tianyu Lan
