From: Thomas Renninger <trenn@suse.de>
Subject: Re: msi s271 (1058)
Date: Thu, 27 Jul 2006 07:22:27 +0200
Message-ID: <1153977748.4302.111.camel@queen.suse.de>
References: <44BB64DC.50804@guetl.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:24750 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750772AbWG0FTo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 01:19:44 -0400
In-Reply-To: <44BB64DC.50804@guetl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andreas guetl <andreas@guetl.net>
Cc: linux-acpi@vger.kernel.org

On Mon, 2006-07-17 at 12:22 +0200, andreas guetl wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> hello!
> 
> i recently bought a msi s271 barebone and stuffed it with an amd turion
> x1 tl-56, 2gb ram and a harddisk. but linux won't start on it when acpi
> is enabled. i tried tons of kernel-configuration (both 64 and 32bit),
> boot-parameters and bios-versions. no success. only if acpi=off is
> appended. so i can't even dump its dsdt table.
> 
> does anyone know a method to get the dsdt table on windows? (windows x64
> that is).
> 
> i searched a lot but found nothing so far.
> 
Just for other msi s271 users:
nohpet boot param makes it boot...

   Thomas


