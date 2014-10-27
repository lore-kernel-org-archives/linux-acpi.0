From: Azael Avalos <coproscefalo@gmail.com>
Subject: Re: PROBLEM: Toshiba R700 backlight control lost on resume
Date: Mon, 27 Oct 2014 09:39:30 -0600
Message-ID: <CAGdLNWGuosjFf-DZet2XrgPiSCq-Ap9qW6GuJZ7-7QYwxjTVQw@mail.gmail.com>
References: <CAN4ACkZtQvHCTikvz5Kh9Sk7s+88Aw9-D-XgfMJ7XbuBs+_70Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:50708 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbaJ0Pjb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2014 11:39:31 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so1593267wgg.28
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2014 08:39:30 -0700 (PDT)
In-Reply-To: <CAN4ACkZtQvHCTikvz5Kh9Sk7s+88Aw9-D-XgfMJ7XbuBs+_70Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Pater <alan.pater@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi there,


So, the backlight device (/sys/class/backlight/toshiba/brightness) can still
be used to change brightness, but not via the hotkeys on resume?

If so, try a recent version (3.18-rc1 or -rc2), Benjamin Tissoires added a
patch (commit e7fdb762b9e1e10c3271e47723b2003330829ddf) to re-
enable the hotkeys after suspend.


Cheers
Azael


-- 
-- El mundo apesta y vosotros apestais tambien --
