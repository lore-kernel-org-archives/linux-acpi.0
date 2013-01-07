From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Excessive power consumption on Sony VAIO VPCZ23A4R
Date: Mon, 7 Jan 2013 17:04:18 +0600
Message-ID: <CAN_LGv34UJoHN7um_h1SFBuxpnjVuGqt452EJE4DEZKhhQPRMg@mail.gmail.com>
References: <CAN_LGv1fZraYbH7LCUwS8L=KsX9vsr8NK7hG+64s51TwPG4mRw@mail.gmail.com>
	<1939348.oLSthUfcvW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60753 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3AGLET (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jan 2013 06:04:19 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so12089218qcr.19
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jan 2013 03:04:19 -0800 (PST)
In-Reply-To: <1939348.oLSthUfcvW@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

2013/1/6 Rafael J. Wysocki <rjw@sisk.pl>:
> Most likely that's not the case.  I suppose that the graphics power management
> is more aggressive on Windows and that depends on the graphics driver.

I have enabled rc6pp by adding the i915.i915_enable_rc6=7 option.
Powertop now says that rc6pp is used, but the effect on power
consumption is not noticeable,

-- 
Alexander E. Patrakov
