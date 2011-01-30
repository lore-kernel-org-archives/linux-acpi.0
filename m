From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] merge 32/64 bits realmode wakeup code
Date: Sun, 30 Jan 2011 13:59:18 +0100
Message-ID: <201101301359.18869.rjw@sisk.pl>
References: <4D41EA12.1030402@free.fr> <201101292215.57292.rjw@sisk.pl> <4D44AE75.6020803@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50022 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744Ab1A3NAC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jan 2011 08:00:02 -0500
In-Reply-To: <4D44AE75.6020803@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: matthieu castet <castet.matthieu@free.fr>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

On Sunday, January 30, 2011, H. Peter Anvin wrote:
> On 01/29/2011 01:15 PM, Rafael J. Wysocki wrote:
> >
> > That's correct, but those changes can wait.  The most urgent thing is to fix
> > the resume regression at hand.  I guess we should ask the reporter's in
> > https://bugzilla.kernel.org/show_bug.cgi?id=27472 to test that patch, right?
> >
> 
> By the way, guys: I'm on vacation at the moment, but I do monitor this 
> thread.  I think at this point we should revert NX for the low 1 MiB and 
> worry about doing it properly for .39.

Fine by me, this is your call anyway.

> That being said, this kind of unification is a good thing in general.

Sure.

Thanks,
Rafael
