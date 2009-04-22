From: Daniel Smoczyk <daniel.smoczyk@gmail.com>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
	mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 17:09:20 +0200
Message-ID: <d7131a800904220809ha96c0e5rd366abfcbae4d1c2@mail.gmail.com>
References: <20090421142751.b030cba7.akpm@linux-foundation.org>
	 <Pine.LNX.4.44L0.0904221050110.3405-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:41419 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZDVPJW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2009 11:09:22 -0400
In-Reply-To: <Pine.LNX.4.44L0.0904221050110.3405-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, rui.zhang@intel.com, shaohua.li@intel.com, yakui.zhao@intel.com, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, imrehg@gmail.com

On Wed, Apr 22, 2009 at 4:51 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:

> In fact the bug report says that 2.6.27 worked okay.

Not true, didn't tested 2.6.27 - there wasn't such one in debian repos.

> However the changes to uhci-hcd between 2.6.27 and 2.6.28 are quite
> minimal. =A0I can't see how any of them could have had this effect. =A0=
It
> must be due to a change somewhere else in the kernel.

Could You please check 26 <-> 27? In my opinion uhci-hcd was able to
autosuspend while mouse wasn't used in 2.6.26 and it isn't able to do
autosuspend now ( C3 works ok after "rmmod uhci-hcd")
This situation is very similar to using usb memory stick non-stop,
when watching move for eg. then processor also never goes below C2.

Daniel Smoczyk
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
