From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI hotplug
Date: Mon, 17 Jan 2005 23:26:35 -0800 (PST)
Message-ID: <20050118072635.9695.qmail@web50204.mail.yahoo.com>
References: <16A54BF5D6E14E4D916CE26C9AD3057501006CA1@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057501006CA1-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Li,

I tried to undock with IBM_ACPI in kernel 2.6.10, and
it hang my laptop.
Then I tried to dock my laptop with IBM_ACPI, it
docked OK (fans starts, led lit), but no new devices
appears like you expected.
Now, I can live with the fact that I have to boot in
dock to see all devices, but what bothers me is that
after booting in dock, and ACPI seeing all devices, I
still can undock/dock reliably even if ACPI has all
the info it needs.

Thanks,
Paul


--- "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
> Docking station generally includes a PCI bridge,
> some PCI devices and/or
> some PNP devices. Support docking station hotplug
> isn't so easy. You
> must support PCI bridge hotplug (acpiphp possibly
> can do something, but
> it doesn't support bridge hotplug. In addition, the
> docking bridge in
> Thinkpad is very special, it's a transparent bridge.
> Normal PCI hotplug
> can't support it.) and support PNP device hotplug
> (PNPACPI is designed
> to do it, but now it doesn't support hotplug).
> IBM_ACPI just can do
> eject and dock, but can't enumerate devices under
> the dock.
> 
> Thanks,
> Shaohua
> 
> >> I do have an IBM Thinkpad, and I am using
> IBM_ACPI
> >> module. But this module is limited in
> functionality
> >
> >OK.
> >
> >> If I boot docked in, I have more ACPI devices
> than if
> >> I boot undocked, and that info is not possible
> for
> >> ACPI to get dynamically when I plug the laptop in
> >
> >I see. Can you please send the dmesg output after
> enabling
> >debug messages in acpiphp (acpiphp supports a
> "debug"
> >module param)?  I'd like to see if acpiphp is even
> >installing a notify handler and triggering at dock.
> >
> >Also, can you send the lspci -vv output with the
> >laptop docked at boot time?
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
