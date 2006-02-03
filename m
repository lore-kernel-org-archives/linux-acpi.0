From: Juhani Rautiainen <juhani.rautiainen@gmail.com>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 17:59:38 +0200
Message-ID: <fad2c7740602030759i65e45a6as29964b8e90aeecd7@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.207]:41577 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750956AbWBCP7j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Feb 2006 10:59:39 -0500
Received: by wproxy.gmail.com with SMTP id i32so744801wra
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2006 07:59:39 -0800 (PST)
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Joerg Sommrey <jo@sommrey.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tony@atomide.com, erik@slagter.name, alan@lxorguk.ukuu.org.uk

On 2/3/06, Brown, Len <len.brown@intel.com> wrote:
>
>
> Certainly the BIOS writer also had access to that document, plus
> documents we do not see, yet they decided NOT to enable C2/C3.

This comes from AMD-768 reveision guide. In product errata there there
is errata number
24 which seems to suggest that you can't enable POS, C2 or C3 states
in single processor
environments. This at the end of errata:
----- snip ----
This workaround will not work for awaking from the C2/C3 state, since
the operating
system has full control. The (ACPI C2/C3) state support is not
required for Microsoft-compatible workstation and server platforms.

It is recommended that BIOS should disable the C2 state by
clearing bit C2EN (device B function 3 offset 4F'h). It is recommended
that BIOS should disable the C3 state by clearing bit C3EN (device B
function 3 offset 4F'h).
---- snip ----

If I understand errata correctly then enabling C2/C3 should be safe in
SMP environment put
not in single processor enviroment. Maybe module should check this
before enabling C3.

Link:
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24472.pdf

Regards,
Juhani
