From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: How to backlight_device_register with some kind of "low prior"
	(for KMS)
Date: Tue, 15 Sep 2009 09:54:20 +0200
Message-ID: <b170af450909150054q5f5958f7rcaf66d16c0fd358a@mail.gmail.com>
References: <b170af450909142324i478b453fw105554eb584e7181@mail.gmail.com>
	 <1253000634.2504.27.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:53505 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZIOHyU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2009 03:54:20 -0400
Received: by ewy2 with SMTP id 2so210090ewy.17
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2009 00:54:23 -0700 (PDT)
In-Reply-To: <1253000634.2504.27.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, dri-devel@lists.sourceforge.net, "Zhao, Yakui" <yakui.zhao@intel.com>, "Barnes, Jesse" <jbarnes@virtuousgeek.org>

OK, you provided me fair amount of texts to read :)

W dniu 15 wrze=C5=9Bnia 2009 09:43 u=C5=BCytkownik Zhang Rui
<rui.zhang@intel.com> napisa=C5=82:
> And I think it may work for you as well, i.e. two backlight sysfs I/F
> may co-exist, it's the user space to decide which I/F to use.

Could you  explain, please, how does work Fn+F5 and Fn+F6 in
notebooks? I thought it generates some ACPI that kernel identifies as
backlight up/down and kernel passes it to module registered with:
backlight_device_register(...)
is that right?

Then two backlight devices would be a problem, I guess?

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
