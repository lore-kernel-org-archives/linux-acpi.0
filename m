From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: RE: [ACPI] Re: [PATCH] S4bios for 2.5.52.
Date: Thu, 19 Dec 2002 08:37:30 +1300
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <000401c2a6cc$ec43a2f0$0101010a@NigelLaptop>
References: <20021218085902.GD1012@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20021218085902.GD1012-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
To: 'Ducrot Bruno' <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, 'Kai Germaschewski' <kai-K3FV8rsiL1oTdZ4mcS17cL1bcanuHkqH@public.gmane.org>
Cc: "'Grover, Andrew'" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Pavel Machek' <pavel-AlSwsSmVLrQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Kai, if you see that S4OS is slower, it is probably a bug
> that have to be
> fixed in swsusp.

There does seem to be a problem with the rw_swap_page_sync routine. Perhaps
not on Pavel's machine (:>), but I've experienced painfully slow suspends
too. Performance was helped immensely by applying a concept that I'll credit
Lyle Seaman for - unrolling rw_swap_page_sync and submitting all the IO for
pages then looping again and waiting on each sync. I found with writing 7000
or so pages (a suspend from init S) that something gets triggered to force
the sync about every 3900 pages anyway.

Regards,

Nigel
