From: Alan Pater <alan.pater@gmail.com>
Subject: Re: PROBLEM: Toshiba R700 backlight control lost on resume
Date: Mon, 27 Oct 2014 10:46:16 -0500
Message-ID: <CAN4ACka7uCuwM8AiB-r_zodjb1xtsr7r_fw0+nKtqtP-sBQx2w@mail.gmail.com>
References: <CAN4ACkZtQvHCTikvz5Kh9Sk7s+88Aw9-D-XgfMJ7XbuBs+_70Q@mail.gmail.com>
 <CAGdLNWGuosjFf-DZet2XrgPiSCq-Ap9qW6GuJZ7-7QYwxjTVQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:63600 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaJ0Pqh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2014 11:46:37 -0400
Received: by mail-la0-f51.google.com with SMTP id q1so2943404lam.38
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2014 08:46:36 -0700 (PDT)
In-Reply-To: <CAGdLNWGuosjFf-DZet2XrgPiSCq-Ap9qW6GuJZ7-7QYwxjTVQw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

No, I need to use /sys/class/backlight/intel_backlight/brightness to
control the backlight after resume.

On Mon, Oct 27, 2014 at 10:39 AM, Azael Avalos <coproscefalo@gmail.com> wrote:
>
> So, the backlight device (/sys/class/backlight/toshiba/brightness) can still
> be used to change brightness, but not via the hotkeys on resume?
>
