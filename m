From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: S3 question
Date: Sun, 26 May 2013 13:36:27 +0200
Message-ID: <51A1F3BB.5070609@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.km31432.keymachine.de ([87.118.86.135]:56485 "EHLO
	mail.cybertec.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab3EZLnN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 May 2013 07:43:13 -0400
Received: from localhost.localdomain (unknown [87.242.20.225])
	by mail.cybertec.at (Postfix) with ESMTPSA id D6E863900413
	for <linux-acpi@vger.kernel.org>; Sun, 26 May 2013 11:36:27 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear ACPI developers,

I have a question about S3 (Suspend To RAM) sleep.

Explicit warning: This mail mentions Windows XP. If you have heart prob=
lems, please skip=20
this mail entirely.

I am currently working with an Atom-based PC for embedded (POS) applica=
tion,
we use a custom modified Linux distribution.

The BIOS is setup in a way so the suspend mode is S3 and video Re-POST =
is
enabled when resuming from S3.

The vendor of the machine tests suspend/resume using Windows XP SP3.
The machine can suspend/resume properly under Linux as well but there i=
s
a big difference.

When resuming, the video is not re-POSTed under Windows XP but the
screen comes back just fine. When resuming under Linux, the first thing=
 that
appears on the screen are some lines in text mode indicating that video=
 re-POST
is happening. (A totally different screen from the screens at powerup.)

Does anyone know:
1. What XP is doing differently here?
2. Can the same sequence be also done under Linux? Maybe with a command=
 line
    option to control the way S3 is done?

Please, use reply-all, I am not subscribed to this mailing list.

Thanks in advance,
Zolt=E1n B=F6sz=F6rm=E9nyi

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
