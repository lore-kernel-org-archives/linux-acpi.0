From: MoRpHeUz <morpheuz@gmail.com>
Subject: Re: Sony Vaio VGN-SZ340 (was Re: sonypc with Sony Vaio VGN-SZ1VP)
Date: Fri, 5 Jan 2007 15:24:36 -0200
Message-ID: <7ce7bf330701050924h47546970w36ed189ed147ddb3@mail.gmail.com>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <20070104154434.7e1a7c83.akpm@osdl.org>
	 <7ce7bf330701041820l5132ddbfsd3dd2b6ea826f3ae@mail.gmail.com>
	 <200701051211.08458.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:63681 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422639AbXAERYh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jan 2007 12:24:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5757180uga
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jan 2007 09:24:36 -0800 (PST)
In-Reply-To: <200701051211.08458.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

> What workaround are you using?

 This one: http://bugzilla.kernel.org/show_bug.cgi?id=7465

> The frequency scaling issue sounds like a BIOS/Linux incompatibility.
> Please open a bugzilla, if you haven't already, and include the
> output from acpidump.

  I agree that it sound like a BIOS/Linux incompatibility. You can
find my acpidump and DSDT inside the link above. That bug is still
opened.

> The nvidia issue sounds like an interrupt issue, so please reproduce
> it using the open source nvidia driver (not the nvidia binary),
> and include the lspci -vv output, dmesg, and /proc/interrupts.

  Will try that !

Thanks !
