From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/5] ACPI / EC: Fix issues related to the event handling.
Date: Tue, 16 Jun 2015 01:19:17 +0200
Message-ID: <2236613.EKZhFJ1YD4@vostro.rjw.lan>
References: <cover.1433734431.git.lv.zheng@intel.com> <cover.1433999639.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50753 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751251AbbFOWxV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2015 18:53:21 -0400
In-Reply-To: <cover.1433999639.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, June 11, 2015 01:21:14 PM Lv Zheng wrote:
> ACPI specification doesn't define the SCI_EVT clearing timing for the EC
> firmware. There could be 4 possible positions the firmware may use to clear
> the SCI_EVT indication:
>  STATUS: After indicating SCI_EVT to the host via the status register
>          (EC_SC), the target can clear SCI_EVT at any time.
>  QUERY: After seeing the query request (QR_EC) written to the command
>         register (EC_CMD) by the host and having prepared the responding
>         event value in the data register (EC_DATA), the target can safely
>         clear SCI_EVT.
>  EVENT: After seeing the event response read from the data register
>         (EC_DATA) by the host, the target can clear SCI_EVT.
>  METHOD: After the event has been handled via the host _Qxx evaluation,
>          the target can clear SCI_EVT.
> 
> The old EC driver re-checked SCI_EVT using the 3rd position, while during
> the race fixes, the new EC driver was switched to re-check SCI_EVT using
> the 1st position. Using the earliest position may help to reduce issues
> when the other races are not fully fixed and there is an ACPI specification
> statement around an expected behavior:
>  The query value of zero is reserved for a spurious query result and
>  indicates "no outstanding events."
> This statement was the motivation of this choice.
> 
> But there are platforms do not follow this definition, since there is also
> a coverity issue left in the new EC driver, the unmatched SCI_EVT clearing
> timing finally was trapped by this coverity issue, and users can see that
> the new EC driver stops processing further SCI_EVTs. The new EC driver then
> implemented EC_FLAGS_QUERY_HANDSHAKE quirk as a workaround for such
> platforms.
> Now more and more reports can be seen for this SCI_EVT clearing timing
> unmatched problem, we need to consider a better approach to fix all of them
> instead of adding new EC_FLAGS_QUERY_HANDSHAKE quirk users.
> 
> This patchset thus finally implements 3 of 4 modes to handle the SCI_EVT
> clearing timing variations (1 was proven by 94411 not compliant to the
> Windows behavior). And according to the tests, chooses the next earlier
> position (the 2rd position) as the default behavior.
> 
> This patchset also fixes the coverity problem so that even though the
> default behavior still cannot match the Windows behavior, it is possible
> for the new EC driver to proceed to handle further SCI_EVT indications.
> 
> Related bug reports are as follows:
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=44161
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=82611
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=94411
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=97381
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=98111
> 
> Lv Zheng (5):
>   ACPI / EC: Cleanup transaction state transition.
>   ACPI / EC: Convert event handling work queue into loop style.
>   ACPI / EC: Add event clearing variation support.
>   ACPI / EC: Fix EC_FLAGS_QUERY_HANDSHAKE platforms using new event
>     clearing timing.
>   ACPI / EC: Fix a code coverity issue when QR_EC transactions are
>     failed.
> 
>  drivers/acpi/ec.c       |  217 +++++++++++++++++++++++++++++++++++++++++------
>  drivers/acpi/internal.h |    1 +
>  2 files changed, 191 insertions(+), 27 deletions(-)

Queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
