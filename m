From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI / table: Add new function to get table entries
Date: Thu, 27 Nov 2014 01:54:37 +0100
Message-ID: <1417069340.vUMviePmL9@vostro.rjw.lan>
References: <1417010474-2399-1-git-send-email-hanjun.guo@linaro.com> <3690114.UPTfuA83uf@vostro.rjw.lan> <5476706E.7080906@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53772 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753311AbaK0AdV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2014 19:33:21 -0500
In-Reply-To: <5476706E.7080906@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On Thursday, November 27, 2014 08:29:34 AM Hanjun Guo wrote:
> On 2014-11-27 6:14, Rafael J. Wysocki wrote:
> > On Wednesday, November 26, 2014 10:01:13 PM Hanjun Guo wrote:
> >> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> >>
> >> The acpi_table_parse() function has a callback that
> >> passes a pointer to a table_header. Add a new function
> >> which takes this pointer and parses its entries. This
> >> eliminates the need to re-traverse all the tables for
> >> each call. e.g. as in acpi_table_parse_madt() which is
> >> normally called after acpi_table_parse().
> >>
> >> Acked-by: Grant Likely <grant.likely@linaro.org>
> >> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> >> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> ---
> >>  drivers/acpi/tables.c | 63 +++++++++++++++++++++++++++++++++++----------------
> >>  include/linux/acpi.h  |  4 ++++
> >>  2 files changed, 48 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> >> index 6d5a6cd..f1debe9 100644
> >> --- a/drivers/acpi/tables.c
> >> +++ b/drivers/acpi/tables.c
> >> @@ -190,30 +190,24 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
> >>  	}
> >>  }
> >>  
> >> -
> >>  int __init
> >> -acpi_table_parse_entries(char *id,
> >> -			     unsigned long table_size,
> >> -			     int entry_id,
> >> -			     acpi_tbl_entry_handler handler,
> >> -			     unsigned int max_entries)
> >> +acpi_parse_entries(char *id, unsigned long table_size,
> > 
> > Why isn't this static?  Are you going to use it somewhere else?
> 
> Yes, we will use it in the following patches to parse
> entries in static ACPI tables.

OK, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
