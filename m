From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 00:22:14 +0200
Message-ID: <200904220022.18232.oliver@neukum.org>
References: <bug-13145-10286@http.bugzilla.kernel.org/> <20090421142751.b030cba7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:57836 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZDUWW0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2009 18:22:26 -0400
In-Reply-To: <20090421142751.b030cba7.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arjan van de Ven <arjan@infradead.org>, rui.zhang@intel.com, shaohua.li@intel.com, yakui.zhao@intel.com, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, daniel.smoczyk@gmail.com, imrehg@gmail.com

Am Dienstag 21 April 2009 23:27:51 schrieb Andrew Morton:
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
>
> It looks like we need to revisit this - 2.6.26 worked OK, so why can't
> 2.6.28?

Not going into C3 without autosuspend is really expected.

> > [1] http://bugzilla.kernel.org/show_bug.cgi?id=12391
> > [2] http://www.bughost.org/pipermail/power/2009-March/001617.html

Going by http://bugzilla.kernel.org/attachment.cgi?id=19780
is the CPU really in C3 under 2.6.26 without autosuspend?

	Regards
		Oliver

