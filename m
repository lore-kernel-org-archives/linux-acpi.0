From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] merge 32/64 bits realmode wakeup code
Date: Sat, 29 Jan 2011 16:19:01 -0800
Message-ID: <4D44AE75.6020803@zytor.com>
References: <4D41EA12.1030402@free.fr> <201101272354.00042.rjw@sisk.pl> <4D447C00.70709@free.fr> <201101292215.57292.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33087 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab1A3ATr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Jan 2011 19:19:47 -0500
In-Reply-To: <201101292215.57292.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: matthieu castet <castet.matthieu@free.fr>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

On 01/29/2011 01:15 PM, Rafael J. Wysocki wrote:
>
> That's correct, but those changes can wait.  The most urgent thing is to fix
> the resume regression at hand.  I guess we should ask the reporter's in
> https://bugzilla.kernel.org/show_bug.cgi?id=27472 to test that patch, right?
>

By the way, guys: I'm on vacation at the moment, but I do monitor this 
thread.  I think at this point we should revert NX for the low 1 MiB and 
worry about doing it properly for .39.  That being said, this kind of 
unification is a good thing in general.

	-hpa
