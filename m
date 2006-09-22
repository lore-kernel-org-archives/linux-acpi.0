From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: [PATCH 2.6.18 1/1] ACPI: limit cstate on noisy thinkpad t43/p models
Date: Fri, 22 Sep 2006 14:13:50 +0100
Message-ID: <E1GQkqk-0003Rh-00@skye.ra.phy.cam.ac.uk>
References: <CFF307C98FEABE47A452B27C06B85BB6018F099A@hdsmsx411.amr.corp.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:17568 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932399AbWIVNOF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 09:14:05 -0400
In-Reply-To: Your message of "Thu, 21 Sep 2006 18:05:36 EDT."
             <CFF307C98FEABE47A452B27C06B85BB6018F099A@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: shadow@serverart.org, linux-acpi@vger.kernel.org

Interesting!

> Are there any T43 users who do not hear this noise?

Not sure about a T43 but I hear a high-pitched noise on my T60.

> Do you hear this noise for both AC and battery modes?

It happens as soon as I pull out the AC power.  Well, more like half a
second after.  It comes from the lower left corner of the laptop as
you are looking at the keyboard, underneath the "Intel centrino duo"
sticker.  For a while I thought it was the wireless card, but
switching it off with the radio kill switch didn't stop the noise.

But if I pull out the AC power while running this shell script:

  while true ; do true ; done

then the noise doesn't start.

Kernel: 2.6.15-25-386 (Ubuntu), UP version (SMP fails on S3)
Hardware: T60, model 1951-C2U (T2400, Intel graphics and wireless)

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
