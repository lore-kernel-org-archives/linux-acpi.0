From: Danny Baumann <dannybaumann@web.de>
Subject: Re: Brightness buttons broken on Toshiba Satellite Proc A100 in
	kernel 2.6.23 (Fedora8)
Date: Tue, 30 Oct 2007 13:21:50 +0100
Message-ID: <1193746910.18110.1.camel@rechenknecht.peppercon.de>
References: <loom.20071016T122903-517@post.gmane.org>
	 <4714CB1A.7010300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:41315 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbXJ3MVw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 08:21:52 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 42028ABA4893
	for <linux-acpi@vger.kernel.org>; Tue, 30 Oct 2007 13:21:51 +0100 (CET)
Received: from [212.80.250.154] (helo=[192.168.1.26])
	by smtp07.web.de with asmtp (TLSv1:RC4-MD5:128)
	(WEB.DE 4.108 #208)
	id 1Imq6R-0001Uk-00
	for linux-acpi@vger.kernel.org; Tue, 30 Oct 2007 13:21:51 +0100
In-Reply-To: <4714CB1A.7010300@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

> > after upgrading to Fedora 8 which brought kernel 2.6.23 with it I can no longer
> > use the brightness buttons (Fn+F6/F7) on my above mentioned laptop. Pressing
> > them generates F6 and F7 key events instead of ACPI events. This used to work
> > fine in Fedora 7's 2.6.22.9 kernel.
> > 
> > Is there anything I can do to debug this? Writing a value to
> > /proc/acpi/video/VGA/LCD/brightness still works fine, so it's just a matter of
> > the key mapping.
> > I would try to debug this myself, if I just knew where to look at; so any
> > pointers in this direction would be appreciated, too.

Ok, I played around with it some more. It seems that on my Laptop the
firmware sends out notifications on Fn+F6/7 press.
Kernel 2.6.23-rc2 worked fine, -rc3 is broken. Reverting ec.c in the
current Fedora kernel to the version in 2.6.23-rc2 makes brightness
control work again. After finding that, I tried the current HEAD version
of ec.c - unfortunately to no avail.
2.6.23-rc3 doesn't show up the (unwanted) key events for Fn+F6/7 though
- this behaviour was introduced in -rc4.

Is it possible to fix the problem with the amount of information
provided? If no, what additional information can I provide?

Thanks,

Danny

