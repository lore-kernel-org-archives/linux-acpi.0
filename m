From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Sun, 16 Jan 2005 11:49:54 +0100
Message-ID: <20050116104954.GA25743@hell.org.pl>
References: <41E81C2C.8010809@bartol.udel.edu> <1105747983.7368.3.camel@tyrosine> <47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41EA2C1D.3030909-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Rich Townsend:
> ...which unfortunately doesn't mean a whole lot to me. How can I install 
> some form of a handler, so that when the EC detects a Smart Battery 
> event (and -- as per the ACPI spec -- sets the EC Alarm Address and Data 
> registers), and then fires off a General Purpose Event, a chunk of *my* 
> code gets run?
> 
> Any pointers for the above questions will be very welcome -- and thanks 
> to everyone who has responded with bug reports so far.

The best way to do this would be to insert a Notify statement in the code.
Here's a snippet from the appropriate method on my machine:

Notify (\_SB.ACAD, 0x80)

Of course, since you have a smart battery it is unlikely that you have an
AC adapter device present in the DSDT, so you'd have to hack up a device
in your tables and acpi_install_notify_handler() against it to have it 
reported.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
