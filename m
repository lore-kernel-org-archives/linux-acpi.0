From: Florian Schricker <fschricker-S0/GAf8tV78@public.gmane.org>
Subject: Re: acpi_ec_space_handler flooding logs
Date: Tue, 16 Aug 2005 22:37:43 +0200
Message-ID: <1124224663.28295.13.camel@x10>
References: <1123000573.12447.15.camel@x10>  <42FC5C0D.4010907@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42FC5C0D.4010907-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-08-12 at 10:21 +0200, Thomas Renninger wrote:

[DSDT fixes]

> > This broken DSDT is currently active, fails with battery as mentioned -
> > and: floods dmesg / /var/log/messages with
> > 
> >   ACPI: acpi_ec_space_handler: bit_width should be 8
> 
> Could you try whether the above suggestions fix your battery?

They did - everything seems to be just fine now.
Thanks a lot!


> I thought this one is workarounded?

Well, uhmm... */me is puzzled


> At least it is tried: ACPI: acpi_ec_space_handler: bit_width should be 8
> but maybe it does not work as expected?

Anything I could check, provide, test?


> You do use the latest kernel?

I use 2.6.12-suspend2-r3; a kernel patched with the common Gentoo
patchset incl. Suspend2 (which I use a lot).

> If not please try your unfixed DSDT with the latest kernel, this
> should be workarounded correctly since (about 2.6.11?), better use
> the latest.

As said above, I'm already running "something" > 2.6.11...


regards,
Florian Schricker

-- 
A most overlooked advantage to owning a computer is: if they foul up
there's no law against wacking them around a bit.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
