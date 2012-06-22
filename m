From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Bug 41722] Clevo M5X0JE hangs in ACPI init
Date: Fri, 22 Jun 2012 13:32:18 -0600
Message-ID: <CAErSpo5wqB2v=MH2V4DDoHfLsK4q6y2D_iXasUp+ATJCxpikkw@mail.gmail.com>
References: <bug-41722-41252@https.bugzilla.kernel.org/> <20120622102904.12F5411F7FA@bugzilla.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46496 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203Ab2FVTck convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jun 2012 15:32:40 -0400
Received: by lbbgm6 with SMTP id gm6so4015293lbb.19
        for <linux-acpi@vger.kernel.org>; Fri, 22 Jun 2012 12:32:38 -0700 (PDT)
In-Reply-To: <20120622102904.12F5411F7FA@bugzilla.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Cc: linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>, bugzilla-daemon@bugzilla.kernel.org

> https://bugzilla.kernel.org/show_bug.cgi?id=3D41722

This system boots Windows fine, but hangs when Linux does an
outb(0x142e) to enable ACPI mode.  Len suggests that this enters SMM
mode, where the BIOS does stuff which we basically cannot debug.  Len
did hazard a guess that MTRR config is a possible difference between
Linux and Windows.

I think we can figure out the Linux MTRR config from the dmesg of a
boot with "acpi=3Doff".  Rog=E9rio, would you mind attaching that log h=
ere
(it's OK if you need to apply the transparent bridge reversion patch).

Then, since I think you do have Windows on the box, can you use a free
trial version of AIDA64 (http://www.aida64.com/) to collect a complete
system report and attach that as well?  With luck, we can extract the
MTRR config under Windows from that.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
