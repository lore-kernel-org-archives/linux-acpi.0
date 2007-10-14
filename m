From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernate shuts off comp but shutdown now -h doesn't
Date: Sun, 14 Oct 2007 22:12:08 +0200
Message-ID: <200710142212.08394.rjw@sisk.pl>
References: <ecf35a1b0710140626x214f02c8vd470eb1d76d4264b@mail.gmail.com> <200710141554.51082.rjw@sisk.pl> <ecf35a1b0710140741n7c2eacd7u4f445cff9150021d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55451 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410AbXJNT4b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Oct 2007 15:56:31 -0400
In-Reply-To: <ecf35a1b0710140741n7c2eacd7u4f445cff9150021d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dev <dev.akhawe@gmail.com>
Cc: kernelnewbies <kernelnewbies@nl.linux.org>, linux-acpi@vger.kernel.org

On Sunday, 14 October 2007 16:41, dev wrote:
> Hey,
> 
> > What happens if you do "echo shutdown > /sys/power/disk" before hibernation?
> 
> Absolutely nothing! No change at all. I did that and then am writing
> this reply. whats supposed to happen?

Ah, I see you did that already before.  Sorry.

It does exactly the same thing as during shutdown (ie. calls
kernel_power_off()), at least I can't tell what's the difference.

What are the last lines printed on the console when you run 'shutdown -h now'?
