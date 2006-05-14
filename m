From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: please git pull ACPI for 2.6.17
Date: Sun, 14 May 2006 20:00:31 +0159
Message-ID: <44677056.1080004@gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB670F3C4@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:19237 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751497AbWENSAz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 May 2006 14:00:55 -0400
Received: by nf-out-0910.google.com with SMTP id o25so10218nfa
        for <linux-acpi@vger.kernel.org>; Sun, 14 May 2006 11:00:54 -0700 (PDT)
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670F3C4@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brown, Len napsal(a):
>> is it possible to do so now, still before .17 release?
> 
> I think that on April 3rd this was appropriate.
> But now 6 weeks later in the release cycle I don't think it is
> appropriate to do such a large pull.
It seemed obvious, I just tried it, because there was a complain on bugzilla.
> 
> I'm assuming this tree will not be pulled until the start of .18.
Never mind.
> 
> Jiri,
> Is there a specific individual patch that you are wanting to have in
> .17?
I wanted to have ecdt-uid-hack there, because asus laptops' acpi is defunct, but
as I said, it doesn't matter, 2.6.18-rc1 is not so far.

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZ3BWMsxVwznUen4RAsk4AKDEhjpLcItL1v1MXe7ZShvTLUmONACgqpG9
uQPOD1X8gS9SX0C2avn8Hj8=
=l1s/
-----END PGP SIGNATURE-----
