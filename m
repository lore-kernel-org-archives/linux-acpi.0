From: Justin Georgeson <justin.georgeson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: CM vs FF buttons
Date: Sat, 27 Nov 2004 00:13:28 -0600
Message-ID: <62c1cd2704112622137154df01@mail.gmail.com>
Reply-To: Justin Georgeson <justin.georgeson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I have an Inspiron 2600 laptop and the sleep button (Fn+Esc) doesn't
seem to trigger an ACPI event. It works in Windows, so I tried
recompiling my DSDT. But that didn't help. Checking out my dmesg
output, I see this. I read some mention of FF vs CM on the gentoo
forums post about fixing your DSDT. They mention a kernel patch to
ignore FF buttons so they might be redetected as CM, but my sleep
button is already CM. Is there a way to see it as FF?

ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]

-- 
; Justin Georgeson
; "Free the mallocs, delete the news"
; http://www.openoffice.org
; http://www.boycott-riaa.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
