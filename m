From: Christoph Groth <cwg@falma.de>
Subject: Re: /sys/class/power_supply/BAT0/ confusion
Date: Wed, 09 Nov 2011 07:54:31 +0100
Message-ID: <87vcqtpyzc.fsf@falma.de>
References: <87wrbfot1l.fsf@falma.de>
	<625BA99ED14B2D499DC4E29D8138F1506526C6FC7E@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59327 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab1KIGyo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Nov 2011 01:54:44 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1RO23W-0006SW-K8
	for linux-acpi@vger.kernel.org; Wed, 09 Nov 2011 07:54:42 +0100
Received: from dra38-5-82-246-248-175.fbx.proxad.net ([82.246.248.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 09 Nov 2011 07:54:42 +0100
Received: from cwg by dra38-5-82-246-248-175.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 09 Nov 2011 07:54:42 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: tianyu.lan@intel.com

Tianyu, thanks for your reaction.

"Lan, Tianyu" <tianyu.lan@intel.com> writes:
> 	> charge_now:2761000
> 	The unit of charge_now is =C2=B5A.
> 	What is data shown on the battery?
> 	29 Wh?

Yes: 29 Wh, 14.4 V, 2 Ah.  Computer and battery are factory-new.

> 	Can you test on 3.1 or higher version?=20

I will, when I have some time on the weekend.

Meanwhile, I observed that one time I booted (always with the same
default debian kernel) /sys/class/power_supply/BAT0/ was different.  It
had files like power_now and energy_now.  Don't know how to reproduce
this, though.

Christoph

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
