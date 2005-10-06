From: "David Mathog" <mathog-Mlb+9xX7RBA8OKIjkCRLjtKIQNXEaThN@public.gmane.org>
Subject: Re: Save power at idle onTyan S2466N-MPX, athcool, etc.
Date: Thu, 06 Oct 2005 13:54:01 -0700
Message-ID: <E1ENckb-0007Dh-00@mendel.bio.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Erik Slagter wrote:

> Please search the mailing list archives for something like amd760,
> amd768, amd76x_pm, smp, or simply my name. This has all been covered.

I already did that.  There is a lot of general discussion but
very few details on the final, working, configuration.  In fact,
having gone through that thread twice already I couldn't determine
for sure what the final, working configuration actually was!
That is what I'm after, in particular:

> > 1. relevant BIOS settings
> > 2. minimum kernel required
> > 3. any extra kernel patches required
> > 4. any extra software (like athcool) required

> BTW I have had several stability issues with the board, so I am not
> going to buy another Tyan board. My previous MSI board always worked
> without any problem.

Yeah, these boards are a bit of a pain.  I've got 20 of them.
Power them all down and turn them back on and the
odds are nil that they'll all come back up again.  One
or more always needs to be reset.  They can also get into a state
where reset is ignored, and since these are rack mounted,
the only way to regain control is to pull the power
supply cord out, wait a bit, and plug it back in again.

Moreover, two of them have failed so far.  But they didn't just
die outright, they started crashing for no good reason.  Perhaps
that's what you're seeing as "instability".  To its
credit Tyan did replace those boards under warranty.  The good ones
never crash, easily staying up for 6 months at a time.
(Under linux, with no graphics or other complex drivers
to confuse them.)  We use ECC memory, maybe that helps.

Regards,

David Mathog
mathog-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org
Manager, Sequence Analysis Facility, Biology Division, Caltech


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
