From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 0/30] return statement cleanup - kill pointless parentheses (fwd)
Date: Tue, 21 Dec 2004 12:34:08 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30024F705D@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, juhl-lkml-poRShpWsAiE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Parens have never confused me into thinking that 'return'
was anything besides a 'return'.  They don't confuse
my editor either, which correctly colors 'return' as
a key-word either way.

Indeed, for compound expressions, I prefer that the parens be present.

return (a * (b + c));

looks better to me than

return a * (b + c);

For returning simple constants, I agree that no parens
is easier on the eye:

return -ENODEV;

But if this were surrounded by a bunch of code that used
parens, return (-ENODEV); is okay with me too.

I agree that "func(arg)" is common style for invoking
a function, and that "keyword (expr)" is common style
for a keyword followed by an expression.  So I guess if
I had to pick, I too would go with "return (expr)"
rather than no space.

I'll apply the part of the patch consistent with above.

thanks,
-Len


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
