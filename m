From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: Battery life difference
Date: Sun, 6 Jul 2008 19:21:59 +0200
Message-ID: <20080706172159.GA12736@x61>
References: <31e679430807050617u3fc706fasee9bb43a151c501f@mail.gmail.com> <20080705082352.4b6be669@infradead.org> <31e679430807050844r30ff74fby7e15641573b42d82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:59632 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbYGFRya (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jul 2008 13:54:30 -0400
Content-Disposition: inline
In-Reply-To: <31e679430807050844r30ff74fby7e15641573b42d82@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, Jul 05, 2008 at 18:44:21 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Sat, Jul 5, 2008 at 6:23 PM, Arjan van de Ven <arjan@infradead.org> wrote:

[...]

> > Also take a look at
> > http://kerneltrap.org/mailarchive/linux-kernel/2008/5/8/1771024 because
> > these patches save like 0.75W in our lab.
> 
> cool, is it merged upstream ?

If I got this right, at least Linux 2.6.25 allows to control this via
"/sys/class/scsi_host/host*/link_power_management_policy". Setting it
to "min_power" does the trick. This is also covered by powertop 1.10
and later.

Regards,
Tino
