From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: Re: ibm-acpi-0.1
Date: Tue, 10 Aug 2004 12:45:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092138355.16885.11.camel@localhost.localdomain>
References: <20040810080826.GD28939@aero.ensim.com>
	 <pan.2004.08.10.10.18.05.651578@yahoo.com>
	 <pan.2004.08.10.11.49.38.39080@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <pan.2004.08.10.11.49.38.39080-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Maw, 2004-08-10 at 12:49, Paul Ionescu wrote:
> station. I also use idectl to enable my cdrom or secondary hard-disk in
> the UltraBay slim, but I have the following problems: DMA is not working
> any more for hdc after "idectl 1 rescan" After some rescan cycles I will
> have a lot of ide1 in /proc/ide/
> 
> See http://bugme.osdl.org/show_bug.cgi?id=2261

The 2.4 kernel supports IDE device hotplugging. The 2.6 maintainer has
consistently refused to merge the change because some bits are ugly
but hasn't done anything else to move it forward either.

You need 2.4 for the ultrabay stuff to work properly right now.

Alan



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
