From: Thomas Renninger <trenn@suse.de>
Subject: Re: Unexpected shutdown - perhaps ACPI related?
Date: Wed, 8 Oct 2008 12:23:20 +0200
Message-ID: <200810081223.20536.trenn@suse.de>
References: <4b97db550810080302j79f9001la5a4c06019701131@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:49815 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011AbYJHKXW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Oct 2008 06:23:22 -0400
In-Reply-To: <4b97db550810080302j79f9001la5a4c06019701131@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brian Schau <brian.schau@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 08 October 2008 12:02:09 Brian Schau wrote:
> Hello,
>
> I am seeing strange behaviour on my laptop.   I've been running
> diverse distributions (OpenSUSE, Ubuntu and others) - my
> current being gOS 3.0 gadgets.
> No matter the distribution I see unexpected shutdowns!   That is - one
> second I work, the other I don't.    The laptop shuts
> itself off without any prior notice.
>
> If I disable ACPI the unexpected shutdown disappears (and I loose a
> bunch of other good stuff :-(
>
> I don't know how to diagnose this further so I am asking for help here.
>
> For starters I've attached the output from lsusb and lspci.
>
> I am running kernel 2.6.24-19.
>
> How to proceed?   I am willing to test ... :-)

Are this critical thermal shutdowns?
grep -i critical /var/log/messages
should reveal that.
If yes:
  - watch your fan/temperature states:
    /proc/acpi/{thermal_zone,fan}
  - Does cpufreq work?
  - Maybe
    echo 15 >/proc/acpi/thermal_zone/*/polling_frequency
    helps then?

     Thomas
