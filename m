From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: generic ACPI video and hotkey drivers vs. platform-specific drivers
Date: 03 Mar 2005 16:08:45 -0500
Message-ID: <1109884125.2102.781.camel@d845pe>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net>
	 <1109790760.2097.587.camel@d845pe>
	 <20050302205324.GA5486@deep-space-9.dsnet>
	 <1109839245.4866.10.camel@nouse.net>
	 <20050303093949.GB3346@crusoe.alcove-fr>
	 <1109844371.4866.31.camel@nouse.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1109844371.4866.31.camel-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, toshiba_acpi-7wiBuN1tZDdg9hUCZPvPmw@public.gmane.org, vojtech-IBi9RG/b67k@public.gmane.org
Cc: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

It is great that programmers -- sometimes with little or no
vendor support -- have come up with platform specific
drivers to make things work on their boxes. But
this is only a stepping stone to where we need to be,
for building special drivers for every platform is not
a solution of first choice, it is a solution of last resort.

The total number of systems already deployed and those
in the pipeline is very large when you account for all
the models from all the vendors -- and this number is
increasing, not decreasing.  If we lead the distros
down this path they will get crushed in a support mess.

As I've said before, it is fine with me for exotic drivers
to handle exotic hardware -- nobody wants to muck-up generic
code for a few exotics.  But we need a design where
standard systems we've never heard of "just work";
and we need to make the use, administration, and support
of exotic systems as much like standard sytems
as possible.

I believe that Bruno's generic video driver (in tree)
is a step in this direction.  I believe that Luming's
generic hot key driver (on list, but not yet in tree)
is a step in this direction.  Are either of these
"final"?  heck no, but I'm confident that they're
heading us in the right direction.

I plan to pull Luming's hot-key driver into the ACPI patch
soon -- the only reason we didnt' do it earlyer is because
the previous version would have immediately broken the
existing platform specific drivers...

We also need to think about the kernel<->user interface
we've currently got.

We need to think through the suggestion that hot keys
should appear to Linux like other keyboard keys -- and
wind their way throught the input layer.  I think the important
thing will be what the user or administrator has to do in
order to map which keys to which functions; and if this
can work automatically without a call to 1-800-distro.
Hopefully we can leverage the stuff people use for keyboard
special keys already.

thanks for your support,
-Len




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
