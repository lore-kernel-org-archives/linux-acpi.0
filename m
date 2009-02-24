From: Corentin Chary <corentincj@iksaif.net>
Subject: Re: [PATCH 2.6.29-rc4] Restore ACPI reporting via /proc/acpi/events for EeePC & other Asus laptops.
Date: Tue, 24 Feb 2009 12:31:02 +0100
Message-ID: <200902241231.02809.corentincj@iksaif.net>
References: <alpine.LFD.2.00.0902081251090.3048@localhost.localdomain> <5030E21460%linux@youmustbejoking.demon.co.uk> <5030E5F170%ds@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:65346 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZBXLbH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Feb 2009 06:31:07 -0500
In-Reply-To: <5030E5F170%ds@youmustbejoking.demon.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Salt <ds@youmustbejoking.demon.co.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>

On Tuesday 10 February 2009 15:54:56 Darren Salt wrote:
> The descriptions for the following two commits
>   2a7dc0d8c60325e9bf820900bf919430e5a419ab (asus-laptop)
>   2b25c9f01aa58d48129b2f93748dfb5d1f7ab0a2 (eeepc-laptop)
> say that events should ALSO be exported via netlink, but the effect is that
> they are INSTEAD exported via netlink. The latter commit breaks use of
> acpid on my EeePC 901.

Hi,
There was already two patch for that on the ml

http://patchwork.kernel.org/patch/7356/
http://patchwork.kernel.org/patch/7357/

Thanks

-- 
Corentin Chary
http://xf.iksaif.net
