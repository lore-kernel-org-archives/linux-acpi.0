From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: Tue, 10 Aug 2004 13:18:09 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.08.10.10.18.05.651578@yahoo.com>
References: <20040810080826.GD28939@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

Hi Boris,

On a T41 it inserts in the kernel only if I replace _SB.GDCK with
_SB.PCI0.PCI1.DOCK.
If I don't, I get the following message:
insmod ./ibm_acpi.ko 
insmod: error inserting './ibm_acpi.ko': -1 No such device

and in dmesg I found:
ibm_acpi: acpi_get_handle(\_SB.GDCK) failed

At a fist glance, hot-keys work, but the Fn-F5 does not enable bluetooth
anymore.
I will get back with more feedback.

Thanks,
Paul

On Tue, 10 Aug 2004 01:08:26 -0700, Borislav Deianov wrote:

> Hi,
> 
> This is the first public release of my ACPI driver for IBM ThinkPad
> laptops. The features currently supported are:
> 
> - hot keys (Fn key combinations)
> - docking and undocking
> - some basic fan speed control
> 
> Note that I've only tested on a ThinkPad X40 with the X4 UltraBase. I
> suspect many other recent models are sufficiently similar to work with
> this driver but I have no such reports yet.
> 
> I'll release this on the linux-thinkpad list as well, but I thought
> I'd get some comments here first. This is my first foray into the ACPI
> code, so do let me know if I'm doing something horribly wrong. :-)
> 
> (Sorry, no web page yet. One thing at a time.)
> 
> Thanks,
> Boris




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
