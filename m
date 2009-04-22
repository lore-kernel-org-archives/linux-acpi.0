From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 10:48:30 +0200
Message-ID: <200904221048.35180.oliver@neukum.org>
References: <bug-13145-10286@http.bugzilla.kernel.org/> <200904220022.18232.oliver@neukum.org> <20090421164910.43d94457@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:41917 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbZDVIsq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2009 04:48:46 -0400
In-Reply-To: <20090421164910.43d94457@infradead.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, rui.zhang@intel.com, shaohua.li@intel.com, yakui.zhao@intel.com, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, daniel.smoczyk@gmail.com, imrehg@gmail.com

Am Mittwoch 22 April 2009 01:49:10 schrieb Arjan van de Ven:
> On Wed, 22 Apr 2009 00:22:14 +0200
>
> Oliver Neukum <oliver@neukum.org> wrote:
> > Am Dienstag 21 April 2009 23:27:51 schrieb Andrew Morton:
> > > (switched to email.  Please respond via emailed reply-to-all, not
> > > via the bugzilla web interface).
> > >
> > > It looks like we need to revisit this - 2.6.26 worked OK, so why
> > > can't 2.6.28?
> >
> > Not going into C3 without autosuspend is really expected.
>
> this is not correct; if the CPU supports "C2-popup", going to C3 is
> expected.

Yes, that's possible. Does the system in question?

	Regards
		Oliver

