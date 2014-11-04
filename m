From: Alan Pater <alan.pater@gmail.com>
Subject: Re: PROBLEM: Toshiba R700 backlight control lost on resume
Date: Tue, 4 Nov 2014 17:49:41 -0500
Message-ID: <CAN4ACkY=pj8JsBqFVN7FAcrR4zRZ_MOvkRUa8FjdDn4agRhmkQ@mail.gmail.com>
References: <CAN4ACkZtQvHCTikvz5Kh9Sk7s+88Aw9-D-XgfMJ7XbuBs+_70Q@mail.gmail.com>
 <CAGdLNWGuosjFf-DZet2XrgPiSCq-Ap9qW6GuJZ7-7QYwxjTVQw@mail.gmail.com>
 <CAN4ACka7uCuwM8AiB-r_zodjb1xtsr7r_fw0+nKtqtP-sBQx2w@mail.gmail.com>
 <CAGdLNWHY6M8TB7ekQEW3=1JUAogLN6zbmsmSXqHYXtRVUUXf7w@mail.gmail.com>
 <CAGdLNWEr0SLF596EDeb6Nr6g7P6ZbLOt5fpudLmvmZqezo9mEw@mail.gmail.com>
 <CAN4ACkbCuxwaRuX0T1VQatF3g=8UikgS_ECfRMbeNgvbYNGxEQ@mail.gmail.com>
 <CAGdLNWFCvNchQwow3qTTF0gDSrWz__LCWd-4eomZ5E5ir-OLrA@mail.gmail.com> <CAN4ACkazYvgUttjf9NMsijg71tuFgpp=SB_u3XpGRco-hFcmew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48442 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbaKDWuE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Nov 2014 17:50:04 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so5365278lbv.12
        for <linux-acpi@vger.kernel.org>; Tue, 04 Nov 2014 14:50:01 -0800 (PST)
In-Reply-To: <CAN4ACkazYvgUttjf9NMsijg71tuFgpp=SB_u3XpGRco-hFcmew@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

As a workaround, creating an xorg.conf file and specifying
"intel_backlight" seems to work. What is needed to let the kernel know
that this model of Toshiba uses Intel?
