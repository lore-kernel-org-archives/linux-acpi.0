From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [regression] v2.6.24-rc1-497-gb1d08ac: kde battery icon gone
Date: Sat, 3 Nov 2007 09:28:08 +0100
Message-ID: <20071103082808.GB10760@elte.hu>
References: <472B5C01.7090508@m3y3r.de> <20071103063520.13EA59AFABF@smtp05.mtu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:45924 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922AbXKCI2Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Nov 2007 04:28:25 -0400
Content-Disposition: inline
In-Reply-To: <20071103063520.13EA59AFABF@smtp05.mtu.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>


* Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> > # CONFIG_ACPI_PROCFS is not set
> 
> And if you enable it (ACPI_PROCFS)?

ACPI_PROCFS was newly introduced i think but without a 'default y' 
Kconfig entry. That was a mistake i think - it broke some power 
management tools on my laptop too.

	Ingo
