From: AnMaster <anmaster@tele2.se>
Subject: Re: DSDT problems with Asus K8V-X SE
Date: Sun, 06 Jan 2008 11:07:06 +0100
Message-ID: <4780A84A.6090903@tele2.se>
References: <477FB74A.7080908@tele2.se> <200801060037.24499.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailfe08.swip.net ([212.247.154.225]:34136 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751480AbYAFLHL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jan 2008 06:07:11 -0500
Received: from [83.177.0.77] (account mj530768@tele2.se HELO [192.168.0.64])
  by mailfe08.swip.net (CommuniGate Pro SMTP 5.1.13)
  with ESMTPA id 755150041 for linux-acpi@vger.kernel.org; Sun, 06 Jan 2008 11:07:07 +0100
In-Reply-To: <200801060037.24499.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Carlos Corbacho wrote:
> On Saturday 05 January 2008 16:58:50 AnMaster wrote:
>> My problem is a broken DSDT, I have tried to fix it, but I don't know if I
>> did it the right way, nor how to solve the warning that remains when the
>> errors are gone.
> 
> What exactly is broken about your DSDT that requires you to 'fix' it? 
> 
> Yes, lots of vendor DSDTs won't compile with the Intel compiler - this is 
> because the Microsoft compiler is far more 'generous' than Intel's, and will 
> allow a lot of spec breaking rubbish in.
> 
> However, the ACPI interpreter in Linux can handle most of these just fine; and 
> if it can't, then that's a bug that needs to be fixed in Linux (since Linux 
> should be able to handle unmodified MS compiled DSDTs out of the box).
> 
> -Carlos

I get lots of lock ups (no kernel oopes or other useful info, just everything locks up) that goes
away when I disable ACPI. Someone on IRC said that I should try to fix the DSDT to see if that helps.

Regards,

Arvid Norlander
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHgKhIWmK6ng/aMNkRCp7zAKDDEn8Deif0QuW6v8IP42VS/2fLuwCfRG9M
QYCXQ3eJrwj+gw2O7Kaydso=
=xOEK
-----END PGP SIGNATURE-----
