From: Duncan Gibb <duncangibb-zbhw9Kw21rH/AQmYMRTMl1aTQe2KTcn/@public.gmane.org>
Subject: HP-Compaq laptops and Linux ACPI (was RE: redhat comment
	about intel not taking patches?)
Date: 13 Feb 2003 16:35:18 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1045154118.14935.64.camel@carwash.duncangibb.com>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E3DB@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10440E3DB-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John   (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: Darren Benham <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2003-02-13 at 04:11, Cagle, John (ISS-Houston) wrote:

JC> it is unreasonable to expect that our laptop and
JC> desktop divisions test with Linux ACPI for two
JC> big reasons: first, the Linux OS has a very small
JC> share of those markets, and second, Red Hat's
JC> releases don't even have ACPI support.

Can I throw in my twopenneth at this point?  Sorry if I repeat anything
that's been said earlier in this thread - I've been busy ;-)

Back in November I had an exchange of emails on this list and with
Richard Black at HP, during which we established that the main thing
that stops Linux ACPI working out-of-the-box on HP notebooks like my Evo
N800c is that the DSDT written into the BIOS on these boxes does not
comply with the ACPI spec.  I sent details of some of the most obvious
violations - with references - to Richard, who said he's pass them on,
but I've heard nothing back.

Which OSes you chose to test/certify on which of your hardware is
entirely a business decision for you.

However, I, as your customer, think that if HP advertises a product as
ACPI-compliant - which you do - and is (through Compaq) a co-author of
the specification with which you're claiming compliance - which you are
- then it's not too much to ask that this claim be true - which
unfortunately, it isn't.

While you might not feel inclined to go out of your way to support Linux
on your notebooks, I don't see that it's advantageous to your business
to go out of your way to obstruct those of us who want/need to use it.

Cheers


Duncan



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
