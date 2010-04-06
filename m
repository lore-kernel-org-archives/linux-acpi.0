From: =?ISO-8859-1?Q?Angel_Pe=F1a_Pe=F1a?= <angelppga@gmail.com>
Subject: Fwd: HP Probook 4510s fan always at high speed
Date: Tue, 6 Apr 2010 11:55:29 +0200
Message-ID: <k2v2666e28c1004060255t971900d2h7b9307cb7f234e6b@mail.gmail.com>
References: <g2y2666e28c1004060244l9918f119n63f5899ac812ca49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:12775 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0DFJzb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 05:55:31 -0400
Received: by ey-out-2122.google.com with SMTP id d26so304373eyd.19
        for <linux-acpi@vger.kernel.org>; Tue, 06 Apr 2010 02:55:29 -0700 (PDT)
In-Reply-To: <g2y2666e28c1004060244l9918f119n63f5899ac812ca49@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: zajec5@gmail.com
Cc: linux-acpi@vger.kernel.org

Rafa=C5=82 Mi=C5=82ecki escribi=C3=B3:
> 2010/3/31 Angel Pe=C3=B1a <angelpp@bigfoot.com>:
>> My new HP Probook 4510s with openSuse 11.2 (kernel 2.6.31) or 11.3
>> Milestone 4 (kernel 2.6.32) always ends running the fan at high spee=
d.
>> There must be a change in the BIOS because in others HP laptops (nx6=
125,
>> nx7300) it didn't occur.
>>
>> Thanks for you attention.
>
> Did you check "top" to make sure your CPU is not processing something
> hardly?

It began to speed up the fan just after system login, before launching
any heavy process.

> Did your userspace downclocked CPU?

The CPU downclock to 1200 MHz from 2200 MHz.

> What is your GPU?

ATI Radeon. I tried the propietary driver but the problem stands still

> I don't think it's anything ACPI related.

I have read in the laptop opensuse forum a problem like this but in a
Dell laptop.

http://forums.opensuse.org/hardware/laptop/434051-continuous-high-fan-s=
peed.html

I think they have changed the BIOS without notice.

Moreover, HP sells this laptop with SuSE Linux preinstalled. They must
know the answer to this problem.


Angel Pe=C3=B1a
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
