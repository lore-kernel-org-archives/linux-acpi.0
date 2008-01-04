From: Alessandro Guido <alessandro.guido@gmail.com>
Subject: Re: Kohjinsha sleep problems
Date: Fri, 4 Jan 2008 22:33:44 +0100
Message-ID: <200801042233.44827.alessandro.guido@gmail.com>
References: <20080101231955.GA1931@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:42239 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbYADVdz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jan 2008 16:33:55 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3669803fga.17
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jan 2008 13:33:54 -0800 (PST)
In-Reply-To: <20080101231955.GA1931@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

Il Wednesday 02 January 2008 00:19:55 Pavel Machek ha scritto:
> Hi!
>
> On kohjinsha, wakeup code does not seem to be reached at all. I tried
> looking around FACS, but it seems very empty:
>
> ...

The same on my laptop:

FACS @ 0x2fefafc0
  0000: 46 41 43 53 40 00 00 00 62 12 00 00 00 00 00 00  FACS@...b.......
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................


I've never been able to resume from STR with Linux (works with Windows Vista). 
STD works, although I have to press the power button in order to resume.
