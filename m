From: Yu Luming <luming.yu@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Thu, 12 Oct 2006 00:48:19 +0800
Message-ID: <200610120048.19953.luming.yu@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061010212341.GA31972@srcf.ucam.org> <200610102320.13952.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:10905 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161139AbWJKQt4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 12:49:56 -0400
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k9BGneZS018918
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2006 16:49:53 GMT
Received: by py-out-1112.google.com with SMTP id z74so240038pyg
        for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2006 09:48:37 -0700 (PDT)
In-Reply-To: <200610102320.13952.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alessandro Guido <alessandro.guido@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

> > It would have to be DMI-based to some extent - not all Sonys use the
> > same keys for the same purpose. Misery ensues.
>
> Then we need to add keymap table to the sonypi's input device so that
> keymap can be changed from userspace.
If some key is physically broken, I agree configurable keymap is the only 
solution. But, I don't see any other benefit of doing so, if we expect 
platform specific driver report meaningful key code to input layer.

Thanks,
Luming
