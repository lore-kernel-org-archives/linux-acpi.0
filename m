From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: ACPI module for Asus Eee PC
Date: Wed, 30 Jan 2008 19:10:46 +0100
Message-ID: <200801301910.46643.corentincj@iksaif.net>
References: <20080126144824.GD16281@stratocaster.home>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:33510 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764540AbYA3SLF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jan 2008 13:11:05 -0500
In-Reply-To: <20080126144824.GD16281@stratocaster.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Cooper <ecc@cmu.edu>
Cc: linux-acpi@vger.kernel.org


Hi,
I'm the maintener of asus_acpi and asus-laptop.

On Saturday 26 January 2008 15:48:24 Eric Cooper wrote:
> I happened to look at the patched asus_acpi.c module that was posted
> by Asus for the Eee PC and noticed that it's 75% dead code
Where and when asus has posted that patch ?

> So I cleaned it up, renamed it eeepc_acpi, and packaged it as a
> separate out-of-kernel Debian package that can be built with
> module-assistant.
>
> Here's the wc comparison:
>  1907  6180 50911 asus_acpi.c
>   453  1434 13037 eeepc_acpi.c
I will look your eeepc_acpi.c, but asus_acpi is clearly deprecated.
I could try to port that to the new asus-laptop.c.


-- 
Corentin 'Iksaif' CHARY
http://xf.iksaif.net
