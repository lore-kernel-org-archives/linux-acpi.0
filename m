From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: generic ACPI video and hotkey drivers vs. platform-specific drivers
Date: Sun, 6 Mar 2005 11:45:06 +0100
Message-ID: <20050306104506.GM3485@openzaurus.ucw.cz>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net> <1109790760.2097.587.camel@d845pe> <20050302205324.GA5486@deep-space-9.dsnet> <1109839245.4866.10.camel@nouse.net> <20050303093949.GB3346@crusoe.alcove-fr> <1109844371.4866.31.camel@nouse.net> <1109884125.2102.781.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109884125.2102.781.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, toshiba_acpi-7wiBuN1tZDdg9hUCZPvPmw@public.gmane.org, vojtech-IBi9RG/b67k@public.gmane.org, Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> We need to think through the suggestion that hot keys
> should appear to Linux like other keyboard keys -- and
> wind their way throught the input layer.  I think the important
> thing will be what the user or administrator has to do in
> order to map which keys to which functions; and if this
> can work automatically without a call to 1-800-distro.
> Hopefully we can leverage the stuff people use for keyboard
> special keys already.

There's utility for X called "hotkeys"; it has hw-specific config files, but
on linux it should be possible to have one generic config file. X are usefull
for displaying overlays telling you current volume setting, etc.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
