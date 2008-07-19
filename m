From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 0/3] acpi: GPE fixes
Date: Sat, 19 Jul 2008 12:37:41 +0100
Message-ID: <4881D205.1000901@tuffmail.co.uk>
References: <487D23C3.5070301@student.cs.york.ac.uk> <487F31D7.30803@suse.de> <20080717121309.GF31732@khazad-dum.debian.net> <487F3B6D.3090507@suse.de> <20080717162628.GB18457@khazad-dum.debian.net> <487F7724.5080905@tuffmail.co.uk> <20080717185032.GD18457@khazad-dum.debian.net> <487F986A.3070504@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:7150 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbYGSLhW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 07:37:22 -0400
Received: by nf-out-0910.google.com with SMTP id d3so237665nfc.21
        for <linux-acpi@vger.kernel.org>; Sat, 19 Jul 2008 04:37:21 -0700 (PDT)
In-Reply-To: <487F986A.3070504@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Here's what I came up with -

1.  I was fighting against EC_FLAGS_QUERY_PENDING.  This was used to ignore
    multiple successive GPE interrupts and treat them as a single GPE instead.
    That's the exact opposite of what we want to do.  Let's get rid of it.

2.  Then we can apply my original patch to fix GPE polling on the Asus EeePC,
    by repeatedly querying for GPEs until there are none left.

3.  Finally, if I'm right then we now know how to handle "GPE interrupt storms".
    Some EC's are raising multiple interrupts before we acknowledge them. but
    they're just telling us how many events are pending.  There's no harm in
    that, so we don't ever need to disable GPE interrupts.  Let's get rid of
    GPE polling mode.  (Code mainly stolen from Alexey).

Patch 3 would benefit from wider testing.  Fortunately there are several open
bugs about GPEs so it should be easy to find testers :-).

Alan

