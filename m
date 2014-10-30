From: Alan Pater <alan.pater@gmail.com>
Subject: Re: PROBLEM: Toshiba R700 backlight control lost on resume
Date: Wed, 29 Oct 2014 20:36:45 -0500
Message-ID: <CAN4ACkazYvgUttjf9NMsijg71tuFgpp=SB_u3XpGRco-hFcmew@mail.gmail.com>
References: <CAN4ACkZtQvHCTikvz5Kh9Sk7s+88Aw9-D-XgfMJ7XbuBs+_70Q@mail.gmail.com>
 <CAGdLNWGuosjFf-DZet2XrgPiSCq-Ap9qW6GuJZ7-7QYwxjTVQw@mail.gmail.com>
 <CAN4ACka7uCuwM8AiB-r_zodjb1xtsr7r_fw0+nKtqtP-sBQx2w@mail.gmail.com>
 <CAGdLNWHY6M8TB7ekQEW3=1JUAogLN6zbmsmSXqHYXtRVUUXf7w@mail.gmail.com>
 <CAGdLNWEr0SLF596EDeb6Nr6g7P6ZbLOt5fpudLmvmZqezo9mEw@mail.gmail.com>
 <CAN4ACkbCuxwaRuX0T1VQatF3g=8UikgS_ECfRMbeNgvbYNGxEQ@mail.gmail.com> <CAGdLNWFCvNchQwow3qTTF0gDSrWz__LCWd-4eomZ5E5ir-OLrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:51266 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbaJ3BhI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2014 21:37:08 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so3491385lbg.36
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2014 18:37:06 -0700 (PDT)
In-Reply-To: <CAGdLNWFCvNchQwow3qTTF0gDSrWz__LCWd-4eomZ5E5ir-OLrA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

OK, I tried the modified module, but no change, I still lose Fn key
control over the backlight after S3 suspend.
While in that state, I can adjust the brightness via the terminal:

   echo 2730 | sudo tee /sys/class/backlight/intel_backlight/brightness
