From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: How to backlight_device_register with some kind of "low prior" (for
	KMS)
Date: Tue, 15 Sep 2009 08:24:20 +0200
Message-ID: <b170af450909142324i478b453fw105554eb584e7181@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:58264 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757356AbZIOGYR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2009 02:24:17 -0400
Received: by ewy2 with SMTP id 2so163346ewy.17
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2009 23:24:20 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>

Hi,

There are some unfunny cases, when ACPI can not be used for
controlling backlight level.

Example can be my Sony VAIO
(http://bugzilla.kernel.org/show_bug.cgi?id=3D11682) where bl control
doesn't work with sony-laptop. This notebook has ATI GPU that is
responsible for backlight level.

So we have to implement that in radeon module, which has access to
card and can just use register/AtomBIOS to manage backlight. Of course
KMS is perfect place for that.

However we don't want to play with controlling backlight when there is
specific vendor driver for that. Many notebooks are well supported by
sony-laptop (and other modules) and in these cases we don't want to
change that.

Is there some way of detecting if there is vendor-specific driver that
cares backlight? Or can we register bl device with some low priority,
so when acpi module registers with higher, it will be used? Hope you
understand what I mean.

Using anything like
is_backlight_dev_already_registered
is not enought, as we can not be sure which kernel module will be loade=
d first.

--
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
