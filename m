From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
 mouse (uhci) is plugged in.
Date: Tue, 21 Apr 2009 14:40:06 -0700
Message-ID: <20090421144006.195f2b52@infradead.org>
References: <bug-13145-10286@http.bugzilla.kernel.org/>
	<20090421142751.b030cba7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60595 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbZDUViN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2009 17:38:13 -0400
In-Reply-To: <20090421142751.b030cba7.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rui.zhang@intel.com, shaohua.li@intel.com, yakui.zhao@intel.com, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, daniel.smoczyk@gmail.com, imrehg@gmail.com

On Tue, 21 Apr 2009 14:27:51 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> (switched to email.  Please respond via emailed reply-to-all, not via
> the bugzilla web interface).
> 
> It looks like we need to revisit this - 2.6.26 worked OK, so why can't
> 2.6.28?
> 

2.6.28 ought to be able to work;

the one caveat is that powertop is reporting more accurate data in
newer kernels (the newer kernels expose more details specifically for
powertop) so it needs to be investigated to make sure this is not just
some cosmetic issue.

(note that C3 might not be the right idea per se with such USB device
in, but that is a different story)


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
