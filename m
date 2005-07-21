From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: RE: Linux v2.6.13-rc3
Date: Thu, 21 Jul 2005 09:49:31 +0200
Message-ID: <20050721074931.GA31615@tangens.sinus.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D@hdsmsx401.amr.corp.intel.com>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello there,
> Re: the EC burst mode regression.
> This is an extremely important fix that has been nagging
> many systems for years.  It has been reported to us by
> distros as well as on kernel.org:
> http://bugzilla.kernel.org/show_bug.cgi?id=3851
> There has been a lot of discussion about this on the
> mailing list and there have been several generations
> of patches.  We are confident that this approach
> is the correct solution, but clearly there are
> some snags.  It is probable that the snags are
> model specific.

I don't know whether this regression is related to the message

Jul 20 21:00:45 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:00:45 miro last message repeated 26 times
Jul 20 21:00:45 miro kernel:  acpi_ec-0217 [23] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:00:45 miro last message repeated 3 times
Jul 20 21:00:45 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:00:45 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:23 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:23 miro last message repeated 26 times
Jul 20 21:05:23 miro kernel:  acpi_ec-0217 [23] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:23 miro last message repeated 3 times
Jul 20 21:05:23 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:32 miro last message repeated 29 times
Jul 20 21:05:32 miro kernel:  acpi_ec-0217 [23] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:32 miro last message repeated 3 times
Jul 20 21:05:32 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:33 miro last message repeated 27 times
Jul 20 21:05:33 miro kernel:  acpi_ec-0217 [23] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:33 miro last message repeated 3 times
Jul 20 21:05:33 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:34 miro last message repeated 25 times
Jul 20 21:05:34 miro kernel:  acpi_ec-0217 [23] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:34 miro last message repeated 3 times
Jul 20 21:05:34 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:41 miro last message repeated 27 times
Jul 20 21:05:41 miro kernel:  acpi_ec-0217 [23] acpi_ec_leave_burst_mo: ------->status fail
Jul 20 21:05:41 miro last message repeated 2 times
Jul 20 21:05:41 miro kernel:  acpi_ec-0217 [22] acpi_ec_leave_burst_mo: ------->status fail

As You can see, this message is generated really many times when trying regular
2.6.13-rc3. I'm reporting it for sure, to let You know that there are more
models which experience this.

The problem occurs on Clevo D610SU, a P4/SiS chipset notebook.
When I saw such a bunch of messages, I reverted back to -rc2 kernel, which is
fine.

If You would like to see anything more detailed (dmesg, DSDT etc.) from the
affected system, let me know.

                       With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
