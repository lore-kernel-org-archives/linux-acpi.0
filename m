From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
 mouse (uhci) is plugged in.
Date: Tue, 21 Apr 2009 16:49:10 -0700
Message-ID: <20090421164910.43d94457@infradead.org>
References: <bug-13145-10286@http.bugzilla.kernel.org/>
	<20090421142751.b030cba7.akpm@linux-foundation.org>
	<200904220022.18232.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33597 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbZDUXrQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2009 19:47:16 -0400
In-Reply-To: <200904220022.18232.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, rui.zhang@intel.com, shaohua.li@intel.com, yakui.zhao@intel.com, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, daniel.smoczyk@gmail.com, imrehg@gmail.com

On Wed, 22 Apr 2009 00:22:14 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> Am Dienstag 21 April 2009 23:27:51 schrieb Andrew Morton:
> > (switched to email.  Please respond via emailed reply-to-all, not
> > via the bugzilla web interface).
> >
> > It looks like we need to revisit this - 2.6.26 worked OK, so why
> > can't 2.6.28?
> 
> Not going into C3 without autosuspend is really expected.

this is not correct; if the CPU supports "C2-popup", going to C3 is
expected.


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
