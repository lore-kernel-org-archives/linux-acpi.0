From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [BUG] ACPI bug in 2.6.17-rc3
Date: Tue, 02 May 2006 12:05:26 +0159
Message-ID: <44572EFD.9070703@gmail.com>
References: <1146549731.16874.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.188]:61410 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751272AbWEBKFf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 May 2006 06:05:35 -0400
Received: by nproxy.gmail.com with SMTP id n29so2146617nfc
        for <linux-acpi@vger.kernel.org>; Tue, 02 May 2006 03:05:34 -0700 (PDT)
In-Reply-To: <1146549731.16874.5.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Cc: linux-acpi@vger.kernel.org

Kasper Sandberg napsal(a):
> hello.. just tried out 2.6.17-rc3 on my amd64 system, and i got this
> backtrace:
> khelper pid 4
> trace:
> activate_task+319 try_to_wake_up+93
> __wake_up_common+68 complete+38
> run_workqueue+136 worker_thread+353
> default_wake_function+0 worker_thread+0
> kthread+219 worke_thead+0
> child_rip+8 worker_thread+0
> kthread+0 child_rip+0
> 
> this happened immediately after vesafb changed resolution, i tried
> without vesafb, still the same..
We need whole bug log, no just the trace. Is it possible to grab it?

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEVy79MsxVwznUen4RAp6tAJ9RvSDGtglFtMUW912z3dJQY75mFwCgu5i5
sKbi0EN6YYKmlUo6qcqvU5c=
=CNZM
-----END PGP SIGNATURE-----
