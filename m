From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Sat, 26 Sep 2015 02:27:43 +0200
Message-ID: <2184252.JT4i34L2sb@vostro.rjw.lan>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com> <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53833 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754137AbbIYX73 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2015 19:59:29 -0400
In-Reply-To: <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Wednesday, September 16, 2015 01:58:06 PM Sudeep Holla wrote:
> acpi_parse_entries passes the table end pointer to the sub-table entry
> handler. acpi_parse_entries itself could validate the end of an entry
> against the table end using the length in the sub-table entry.
> 
> This patch adds the validation of the sub-table entry end using the
> length field.This will help to eliminate the need to pass the table end
> to the handlers.
> 
> It also moves the check for zero length entry early so that execution of
> the handler can be avoided.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> ---
>  drivers/acpi/tables.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> Hi Rafael,
> 
> As I mentioned earlier, this needs to be applied after Al's MADT changes
> are merged. You might get simple conflicts in acpi_parse_entries.

This needs to be rebased on top of some patches in my linux-next branch.

It probably is better to rebase it on top of my bleeding-edge branch that
contains the Al's patches already, though.

Thanks,
Rafael

