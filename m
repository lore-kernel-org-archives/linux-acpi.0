From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: fix acpi_parse_entries_array() so it reports
 overflow correctly
Date: Fri, 1 Jul 2016 23:40:06 +0200
Message-ID: <CAJZ5v0hmfnARBC1+ZaGoJtQoHJ-Pp2mwz7HRR5EVybX0o--cxg@mail.gmail.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com> <1467408081-7418-4-git-send-email-ahs3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467408081-7418-4-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 1, 2016 at 11:21 PM, Al Stone <ahs3@redhat.com> wrote:
> The function acpi_parse_entries_array() has a limiting parameter,
> max_entries, which tells the function to stop looking at subtables
> once that limit has been reached.  Further, if the limit is reached,
> it is reported.  However, the logic is incorrect in that the loop
> to examine all subtables will always stop when exactly max_entries
> have been found, regardless of whether or not there are still subtables
> to examine, and it will always report that zero subtables have been
> ignored.  This change allows the loop to continue to look at all
> subtables and count all the ones of interest; if we have already
> reached the number of max_entries, though, we will not invoke the
> callback functions.  If the max_entries limit has been exceeded,
> report on that, as before, but more accurately, listing how many
> subtables of interest there are in total (as was meant), and how
> many entries each subtable type occupied.

The problem appears to be that, if max_entries has been reached, it
prints "ignored 0", although it should count all of the entries in
that case too in principle.  Do I think correctly?
