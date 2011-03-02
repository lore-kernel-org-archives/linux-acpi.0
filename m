From: Jorge Bastos <mysql.jorge@decimal.pt>
Subject: Re: [Bugme-new] [Bug 29922] New: irqpool crash
Date: Wed, 02 Mar 2011 23:01:31 +0000
Message-ID: <b6e05e5377137cf8d6e0a78ed1b9f60c@192.168.1.222>
References: <bug-29922-10286@https.bugzilla.kernel.org/> <20110301152833.66dc5e6f.akpm@linux-foundation.org> <alpine.LFD.2.02.1103021721590.12344@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.decimal.pt ([195.23.114.76]:38706 "EHLO smtp.decimal.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757965Ab1CBXIc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Mar 2011 18:08:32 -0500
In-Reply-To: <alpine.LFD.2.02.1103021721590.12344@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

Hi Len,

> 
> The dmesg is 2.6.35.11
> Does any version of linux earlier or later work properly?
> 

Well, I have no idea.
With newer kernels I have other type of crash's with a mandatory reboot
'cause the machine just stop's working.
Since this is a production server I can't do that test for you :(
Anyway I'd do that test for you if the machine wasn't production.

This crash I sent, didn't stop the machine as it continued working
normally.

What can I do to help track this? (other than using a newer kernel than
2.6.35.11)

Jorge,
