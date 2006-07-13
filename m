From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: ACPI: SBS in linux-2.6.18-rc1 - Works for me!
Date: Thu, 13 Jul 2006 10:20:44 +0200
Message-ID: <m21wspj4pv.fsf@phoenix.squirrel.nl>
References: <44B5FCEC.8040903@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:13075 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP id S932227AbWGMIUv
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jul 2006 04:20:51 -0400
In-Reply-To: <44B5FCEC.8040903@rrz.uni-koeln.de> (Berthold Cogel's message
 of "Thu, 13 Jul 2006 09:57:32 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Berthold Cogel <cogel@rrz.uni-koeln.de> writes:

> I've tested linux-2.6.18-rc1 with Smart Battery System enabled. It
> works for my Acer Extensa 3002 WLMi.

That's good to hear!

> Is it possible to load sbs and i2c-ec automatically together with the
> other ACPI modules? On my Debian system I had to load the modules via
> /etc/modules.conf.

I use a similar approach (for the 'old style' SBS) in /etc/rc.local:

  /sbin/modprobe -r battery
  /sbin/modprobe -r ac
  /sbin/modprobe i2c-acpi-ec
  /sbin/modprobe acpi-sbs

W.r.t. enabling/disabling ac&battery when sbs is selected: I'm not so
sure if that would be a good idea. You build a kernel with modules,
and at some later stage it is selected which modules will be actually
be used.

-- Johan

