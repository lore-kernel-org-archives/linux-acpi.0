From: Shreyas <shreyas_a-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpid doesn't log all ACPI events
Date: Sun, 29 Aug 2004 20:58:46 +0000 (UTC)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <loom.20040829T225203-748@post.gmane.org>
References: <B774920D825C2D4880A3C1B0D6EF941801CEEA87@ssdmx.ssd.fsi.com> <1093379626.17222.283.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown <len.brown@...> writes:

> 
> On Fri, 2004-08-20 at 16:22, Rockefeller, Harry wrote:
> > I am running acpi and kernel 2.6.8.1 and acpid version 1.0.3.
> > 
> > I get ACPI debug messages at the system terminal when I change
> > my notebook power from AC to battery and vice versa, i.e.,
> > 
> > [ACPI Debug] String: Length 0x09, "AC Change".
> > 
> > Also /proc/acpi/ac_adapter/AC0/state reports the power change
> > properly.
> > 
> > However, acpid never records ac_adapter events.
> > 
> you mean your system doesn't do this?:

<snip>

I have the same problem in Dell Inspiron 5150 running 2.6.7 with acpi patch
(2004-07-17). The acpi events (battery, ac_adapter, lid) are not generated
during normal operation. However, if I enter S1,S3 or S4 the ac_adapter events
are output during the suspend event. It shows up in /var/log/acpid upon resume.  





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
