From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: "Device is not power manageable"
Date: Tue, 21 Feb 2006 07:41:26 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602210737430.8603@shark.he.net>
References: <20060221042708.653944c1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:10396 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932737AbWBUPl2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 10:41:28 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2006 07:41:26 -0800
In-Reply-To: <20060221042708.653944c1.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 21 Feb 2006, Andrew Morton wrote:

>
> What does this mean?
>
> sony:/home/akpm> dmesg -s 1000000 | grep 199
> Detected 1995.262 MHz processor.
> Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> e100: Copyright(c) 1999-2005 Intel Corporation
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
>
> <suspend-to-ram>
> <resume>
>
> ACPI Error (evevent-0314): No installed handler for fixed event [00000002] [20060210]
>
>
> And how does one identify that device?

I have posted a patch for that (2 times iirc) but it seems
to have been dropped/lost (I can't even find it in the email
archives).  It's at home, I can repost it tonight, but it's
fairly trivial:  just print something like dev->bus_id (just
guessing from not recent memory).  I'll send it tonight.

-- 
~Randy
