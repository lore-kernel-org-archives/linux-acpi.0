From: Len Brown <lenb@kernel.org>
Subject: Re: Why is it so hard to (get) help on ACPI?
Date: Thu, 17 May 2007 16:32:18 -0400
Message-ID: <200705171632.18755.lenb@kernel.org>
References: <200705172005.47845.matija.suklje@rutka.net> <8f8ff01d0705171158q3412f0f1o4465562bb961d774@mail.gmail.com> <200705172152.13046.matija.suklje@rutka.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44290 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758984AbXEQUeA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 16:34:00 -0400
In-Reply-To: <200705172152.13046.matija.suklje@rutka.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matija =?utf-8?q?=C5=A0uklje?= <matija.suklje@rutka.net>
Cc: linux-acpi@vger.kernel.org

> I *think* I need it because I didn't find any better solution. On my Acer 
> Aspire 5022 for some time I've been getting APIC errors (most commonly "40
> (40)")

APIC errors have nothing to do with ACPI.
(other than the fact that on lots of systems, ACPI is required
if you want to configure the APIC).

If you don't like the APIC errors, then run with "noapic".
very few laptop uses would notice a difference.

> But this still doesn't explain why it seems like I cannot make a user account 
> on the acpi.sf.net/dsdt page and why my previous e-mail did not arrive to the 
> list. Is the attachment size quota set to less then 1 MiB?
> 
> best regards and kudos for all your hard work on ACPI!

acpi.sf.net is used as a project home page, but we otherwise
don't use the services of sourceforge.

we use bugzilla.kernel.org for Linux/ACPI bugs
we use this list on vger.kernel.org -- which has a 100K limit.
If you want to file a bug and attach a dsdt, use the bugzilla above.

cheers,
-Len
