From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [linux-pm] [PATCH 1/2] suspend: Move NVS save/restore code to
 generic suspend functionality
Date: Fri, 11 Jun 2010 10:32:19 -0300
Message-ID: <20100611133219.GD28084@khazad-dum.debian.net>
References: <1275416390.3778.7.camel@maxim-laptop>
 <201006012331.59747.rjw@sisk.pl>
 <1275429125.5573.7.camel@maxim-laptop>
 <201006020040.22429.rjw@sisk.pl>
 <1275432410.6733.4.camel@maxim-laptop>
 <20100610135816.GG4514@ucw.cz>
 <20100610140911.GA11193@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57542 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760285Ab0FKNc0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 09:32:26 -0400
Content-Disposition: inline
In-Reply-To: <20100610140911.GA11193@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pavel Machek <pavel@ucw.cz>, Maxim Levitsky <maximlevitsky@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>

On Thu, 10 Jun 2010, Matthew Garrett wrote:
> On Thu, Jun 10, 2010 at 03:58:16PM +0200, Pavel Machek wrote:
> > Well... should we only do it in 'platform' hibernation mode? There are
> > machines that predate windows/acpi and still should hibernate.
> 
> If they predate acpi then they won't declare any NVS regions.

What if they're ACPI and APM capable, and in APM mode?  Would the code need
to guard against that?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
