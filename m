From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.29-rc2] First suspend after reboot resumes immediately.
Date: Mon, 19 Jan 2009 21:46:26 +0100
Message-ID: <200901192146.26753.rjw@sisk.pl>
References: <200901192339.03967.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39550 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbZASUrO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Jan 2009 15:47:14 -0500
In-Reply-To: <200901192339.03967.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-usb@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 19 January 2009, Andrey Borzenkov wrote:
> Subsequent suspends seem fine. I suspect it is related to USB controller; 
> but because I see ACPI related message this is sent to linux-acpi as well.
> 
> Specifically, I am suspicious of this:
> 
> [  132.763954] ohci_hcd 0000:00:02.0: wake-up capability enabled by ACPI   
> 
> The controller immediately resumes after any attempt to suspend it, so any 
> autosuspend functionality is currently disabled. But it /looks/ like ACPI 
> somehow tries to do it anyway.
> 
> I can also reproduce it by unloading and reloading USB drivers which 
> supports USB guess.

This looks like http://bugzilla.kernel.org/show_bug.cgi?id=12399 .

Thanks,
Rafael
