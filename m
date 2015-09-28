From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Mon, 28 Sep 2015 15:50:22 +0200
Message-ID: <3513292.8DqxMl02v0@vostro.rjw.lan>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com> <2184252.JT4i34L2sb@vostro.rjw.lan> <5609123F.7020307@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5609123F.7020307@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, September 28, 2015 11:11:11 AM Sudeep Holla wrote:
> 
> On 26/09/15 01:27, Rafael J. Wysocki wrote:
> > On Wednesday, September 16, 2015 01:58:06 PM Sudeep Holla wrote:
> >> acpi_parse_entries passes the table end pointer to the sub-table entry
> >> handler. acpi_parse_entries itself could validate the end of an entry
> >> against the table end using the length in the sub-table entry.
> >>
> >> This patch adds the validation of the sub-table entry end using the
> >> length field.This will help to eliminate the need to pass the table end
> >> to the handlers.
> >>
> >> It also moves the check for zero length entry early so that execution of
> >> the handler can be avoided.
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>
> >> ---
> >>   drivers/acpi/tables.c | 31 +++++++++++++++----------------
> >>   1 file changed, 15 insertions(+), 16 deletions(-)
> >>
> >> Hi Rafael,
> >>
> >> As I mentioned earlier, this needs to be applied after Al's MADT changes
> >> are merged. You might get simple conflicts in acpi_parse_entries.
> >
> > This needs to be rebased on top of some patches in my linux-next branch.
> >
> > It probably is better to rebase it on top of my bleeding-edge branch that
> > contains the Al's patches already, though.
> >
> 
> I don't see Al's patches in your linux-next or bleeding-edge

They were there, but I've dropped them due to a 0-day testing failure.

I think your patches depend on the Al's ones, is that correct?

Rafael
