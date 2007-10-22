From: Frans Pop <elendil@planet.nl>
Subject: Re: latest 2.6.23 git missing ACPI POWER_SUPPLY
Date: Mon, 22 Oct 2007 13:10:33 +0200
Message-ID: <E1IjvB3-0005oG-N9@faramir.fjphome.nl>
References: <b6a2187b0710220045q2920c0dat9ebe4850b02d1bbf@mail.gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753397AbXJVLKt@vger.kernel.org>
In-reply-To: <b6a2187b0710220045q2920c0dat9ebe4850b02d1bbf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Jeff Chua wrote:
> Just pulled latest linux-2.6, and couldn't get ACPI to detect
> ACPI_BATTERY and ACPI_AC.
> 
> It seems ACPI POWER_SUPPLY is still missing.

I had the same problem. It turns out you need to enable
   drivers -> Power supply class support
(either built in or as module) to get ACPI AC/Battery support.

I must say that having these relatively top-level ACPI settings depending on something that is relatively buried away is not very intuitive!
Especially not since at first glance you don't really seem to need that option except for some weird hardware.

CC'ing ACPI mailing list for other opinions.
