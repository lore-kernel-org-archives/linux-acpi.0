From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/3] Correct errors in acpi_parse_entries_array()
Date: Tue, 13 Sep 2016 00:10:57 +0200
Message-ID: <2194773.SQX6EZDjzC@vostro.rjw.lan>
References: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, August 19, 2016 06:48:10 PM Al Stone wrote:
> Several strange things were found while prototyping a way to correctly
> report whether or not an IORT is needed by an arm64 platform.  What the
> prototype needed to do was iterate over the MADT subtables and look for
> certain types of subtable, count how many there were by type, and capture
> some info about some of the subtables.
> 
> When I first read through the acpi_parse_entries_array() function, the
> comments seemed to describe precisely what I needed to do.  However, what
> I found in trying to use the function is that that is not exactly how it
> works.
> 
> So, the first patch fixes the counts of subtable types found so they are
> correct.  Fortunately, nothing has relied on them being correct in the 
> past, just non-zero or not.  This has also been noted by Baoquan He in a
> patch he recently submitted.
> 
> The second patch fixes a problem where iterating over the subtables would
> end earlier than necessary, again throwing off the counts; in this case,
> I only needed to know how many of certain types of subtables were present,
> but would never be able to get to a complete count.
> 
> The third patch removes part of a message that always reported an incorrect
> value for the number of subtables skipped when there's a limit.  It always
> reported zero, so it's never really been useful.
> 
> Longer term, I would like to simplify the way MADT and other ACPI tables
> with subtables are parsed; mostly, I want to get rid of the need for using
> file scoped variables.  The acpi_parse_entries_array() function can be a
> good basis to build upon, as long as it works as expected.
> 
> Changes since v1:
>   -- Much rewrite of the cover letter and changelogs to make sure the 
>      motivation for the changes was captured (Rafael)
>   -- Verified that the changes in semantics for the function are harmless;
>      direct calls, parents/grandparents/.. of the direct calls were checked
>      to make sure they did not depend on the current behavior in such a way
>      as to break them with these changes (Rafael)
>   -- Patch 3/3 was simplified; on further investigation, should additional
>      callbacks be made to get the total skipped, there could be side effects
>      or dependencies between callbacks that would make the original plan of
>      iterating over all callbacks risky, for very little value (Rafael)
> 
> Al Stone (3):
>   ACPI: fix incorrect counts returned by acpi_parse_entries_array()
>   ACPI: fix acpi_parse_entries_array() so it traverses all subtables
>   ACPI: do not report the number of entries ignored by
>     acpi_parse_entries()

All applied.

Thanks,
Rafael
