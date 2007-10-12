From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: halt does not shut the system down
Date: Fri, 12 Oct 2007 21:29:41 +0200
Message-ID: <3efb10970710121229q15de054al1cc5828389faff78@mail.gmail.com>
References: <470A58AF.9080402@free.fr> <470B366F.4030306@free.fr>
	 <3efb10970710091304g30ab5549u84a092d4de40368b@mail.gmail.com>
	 <470CA1BD.1080502@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.235]:46329 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162AbXJLT3o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Oct 2007 15:29:44 -0400
Received: by hu-out-0506.google.com with SMTP id 19so606452hue
        for <linux-acpi@vger.kernel.org>; Fri, 12 Oct 2007 12:29:43 -0700 (PDT)
In-Reply-To: <470CA1BD.1080502@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, len.brown@intel.com

Hello John,

> Thanks for the suggestion. I didn't see anything related to SMM in the
> BIOS menus. However, the system has real-time constraints. Thus, I'd
> turn SMM off if I knew how :-)

Here you can find a driver that can disable and enable the SMI
interrupt in the chipset. It supports up to the ICH5 chipsets, but by
adding the proper device/vendor IDs you can also make it support newer
chipsets.
http://www.bohmer.net/smi.tar.bz2

> AFAIU, poweroff is equivalent to halt -p

You are right.

Kind Regards,

Remy
