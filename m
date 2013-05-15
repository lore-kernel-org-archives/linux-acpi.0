From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Disable hibernate -- Live media shouldn't allow it?
Date: Thu, 16 May 2013 00:29:14 +0200
Message-ID: <1613817.TcdBxdmQtn@vostro.rjw.lan>
References: <519408C1.9030706@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49799 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab3EOWUj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 May 2013 18:20:39 -0400
In-Reply-To: <519408C1.9030706@ubuntu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, May 15, 2013 06:14:25 PM Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> When booting from removable media, you may end up mounting a swap
> partition on an internal hard disk, thus enabling hibernation.
> Inadvertently hibernating ( perhaps in response to ACPI HOT event ) is
> silly since the system can not be resumed.  Is there a flag somewhere
> to prevent hibernating?  Shouldn't there be and shouldn't it be
> disabled by default?

I don't think we have a good definition of "removable media".

Also, you usually can remove a normally non-removable disk while hibernated,
so I just don't see why we should disable it in any case.

That said, it is reasonable to expect live CDs not to configure the system to
hibernate in response to overheating etc.  But that's not a problem we can
address in the kernel.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
