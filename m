From: Alessandro Guido <alessandro.guido@gmail.com>
Subject: Re: [PATCH 2/4] Remove /proc/acpi/sony interface and implement
 platform_device.
Date: Sat, 10 Feb 2007 02:47:19 +0100
Message-ID: <20070210024719.37413cfc@localhost>
References: <11708749163025-git-send-email-malattia@linux.it>
	<11708749161009-git-send-email-malattia@linux.it>
	<11708749161045-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:59895 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbXBJBsj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 20:48:39 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1404850nfa
        for <linux-acpi@vger.kernel.org>; Fri, 09 Feb 2007 17:48:37 -0800 (PST)
In-Reply-To: <11708749161045-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Thanks for doing this! I hope this will be merged soon in mainline :)
I'm testing it on my VGN-FS215S and so far I haven't noticed any
problem.

Just a thing:

brightness_default uses values starting from 1. In my opinion, it should
be changed to use values starting from 0 to have some consistency or,
better, have an entry itself in the backlight interface.

What do you think?

-Alessandro
