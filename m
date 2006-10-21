From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI and CDROM problems
Date: Sat, 21 Oct 2006 16:04:57 +0200
Message-ID: <200610211604.57803.rjw@sisk.pl>
References: <20061021.065827.78720699.wl@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48809 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S2993047AbWJUOFU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Oct 2006 10:05:20 -0400
In-Reply-To: <20061021.065827.78720699.wl@gnu.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Werner LEMBERG <wl@gnu.org>
Cc: linux-acpi@vger.kernel.org

On Saturday, 21 October 2006 06:58, Werner LEMBERG wrote:
> 
> I have an inspiron 6400 (running SuSE 10.0), using kernel 2.6.18
> (unmodified) together with harddisk suspend.  This laptop showed
> severe problems at resuming with 2.6.17 (about 1 out of 5 resumes
> failed).  Now, with 2.6.18, about 1 out of 30 doesn't work.
> 
> It takes about 20 seconds, then a normal reboot happens.

I assume this is the suspend to RAM that doesn't work?  Have you tried using
swsusp (suspend to disk)?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
