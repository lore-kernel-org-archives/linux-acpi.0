From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: HP Compaq nc6320 - Booting on battery power causes softlock
Date: Wed, 17 Jan 2007 11:04:08 +0800
Message-ID: <3877989d0701161904u6ef2b931t99b79d92dd974f2a@mail.gmail.com>
References: <1169002596.29755.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:31254 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbXAQDEJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jan 2007 22:04:09 -0500
Received: by wr-out-0506.google.com with SMTP id i20so485016wra
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jan 2007 19:04:08 -0800 (PST)
In-Reply-To: <1169002596.29755.5.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

The first thing is to make sure you are running the latest bios, kernel.
Then, you need to sort out the kernel component/modules/drivers that
cause the problem.
If you guess it is ACPI issue, pleas test boot option acpi=off to see
if the problem goes away. If you guess it is battery issue, please
remove battery module, etc.
Please don't forget to enter a bug in bugzilla.kernel.org.

Thanks,
Luming

On 1/17/07, Peter Clifton <pcjc2@cam.ac.uk> wrote:
> Hi, I've got an issue with my HP Compaq nc6320, where it won't boot off
> its battery without softlocking on CPU#0. I remember it booting ok off
> battery occasionally in the past, but once I've seen the fault - the
> only way I can get it to boot is off AC. (I usually boot off AC anyway).
>
> I'm presuming ACPI as a good starting point, since that is an area where
> AC / Battery may make a difference.
>
> Can anyone suggest a debugging procedure to identify the cause of a
> softlock, and where would be appropriate (which category) to file a
> kernel bug for this?
>
>
