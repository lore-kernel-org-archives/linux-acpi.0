From: Patrick Ale <patrick.ale-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: Sat, 05 Mar 2005 09:10:16 +0100
Message-ID: <1110010216.26873.29.camel@lilith.cathedrallabs.org>
References: <20050304234622.63e8a335.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050304234622.63e8a335.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I have  a VIA USB chipset aswell but didn't try 2.6.11 yet, I am
compiling it now to see if I have the same problems.

One thing I notice in the lspci output tho is that his chipset doesn't
seem to be detected correctly. When I do an lspci -vvv on 2.6.10 for 
example I get this:

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80) (prog-if 00 [UHCI])

The "Wrong ID" appears in his lspci when he uses acpi=off aswell.

Maybe I am just ranting, maybe it helps :)

Anyway, I will let you know my experience with 2.6.11.

Patrick

On Fri, 2005-03-04 at 23:46 -0800, Andrew Morton wrote:
> Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
