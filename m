From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: fan always on: ACPI on IBM ThinkPad R51
Date: 01 Sep 2004 13:08:17 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094058497.2053.8.camel@d845pe>
References: <20040901100349.4B7A28254@smtp.causaencantada.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040901100349.4B7A28254-1pm5EDj67X3XwkDZ9D75p87Q1tIk23pb@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: susinho-32FzPoaopq1AfugRpC6u6w@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org, Zhenyu Z Wang <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-09-01 at 06:05, susinho-32FzPoaopq1AfugRpC6u6w@public.gmane.org wrote:
> Thank you for this info.
> 
> I opened the laptop and found a three wire connector to the fan, wich
> usually means speed control by BIOS. Disconnecting the fan, a "Fan
> failure" appears and booting process stops. So I supose the fan speed
> and switches are controlled by non-ACPI parts of the BIOS.
> 
> In this case, adding a fan device in the dsdt could make ACPI handle the
> fan?  Is this possible, or the only way is to modify the BIOS?

Such an ACPI device would need methods, and those methods would
read and write platform-specific hardware registers.  This is the
job of the BIOS writer at IBM.  But apparently on this model IBM
has a non-ACPI means to handle the fans, probably an embedded
controller.

-Len

> O 31/8/2004, "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> escribiu:
> 
> >There is no fan device in your dsdt. That means ACPI fan driver couldn't
> >handle it.
> >



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
