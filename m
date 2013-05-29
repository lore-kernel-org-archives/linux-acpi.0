From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: System slow down from udev
Date: Wed, 29 May 2013 13:13:46 -0700
Message-ID: <CAE9FiQX99+V-jS_h9Lr=mz_n8e1KazUOxcLrAyPG19KJM_3ABg@mail.gmail.com>
References: <CAE9FiQUbSeCGTsukX3zfVYBhFKgWfVd8WDDvpix==wSXzc=RVQ@mail.gmail.com>
	<2013173.c6WKZTQWxj@vostro.rjw.lan>
	<CAE9FiQUqHBuoAMeLYDa1GCD8yD+S1QHwxnF4gVPFpgQaatf+Hg@mail.gmail.com>
	<7385243.PHJHW0xyGs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49177 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965519Ab3E2UNr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 May 2013 16:13:47 -0400
In-Reply-To: <7385243.PHJHW0xyGs@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, May 29, 2013 at 4:29 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On your systems the processor driver is built-in.  Any chance to build it as
> a module and see if that helps?

it CONFIG_ACPI_PROCESSOR it not set in the config
the boot get to normal speed.

Yinghai
