From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Thu, 26 Nov 2009 12:02:55 -0500
Message-ID: <jwvtywhte7q.fsf-monnier+gmane.linux.hardware.thinkpad@gnu.org>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	<alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
	<1259170225.4391.4.camel@laptop>
	<alpine.LFD.2.00.0911251317480.3950@localhost.localdomain>
	<20091126050748.GA7874@srcf.ucam.org>
	<cb0375e10911252200t2e4eb852q88d3b9015a75c071@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53015 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760841AbZKZRD2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2009 12:03:28 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NDhkj-0002d5-I0
	for linux-acpi@vger.kernel.org; Thu, 26 Nov 2009 18:03:33 +0100
Received: from 69-165-135-63.dsl.teksavvy.com ([69.165.135.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2009 18:03:33 +0100
Received: from monnier by 69-165-135-63.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2009 18:03:33 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-thinkpad@linux-thinkpad.org

> without this change the mute button breaks sound for everyone except
> power users (who else is supposed to know to twiddle
> /proc/acpi/ibm/volume or press "sound up" to get sound back when the

Most/all the laptops I've seen until now behave like that: the "mute"
button never unmutes.

And as a user, after muting or changing the sound-level with
those special keys, I find that the most obvious way to undo or refine
such a change would be performed with those keys as well.


        Stefan

