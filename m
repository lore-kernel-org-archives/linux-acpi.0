From: Marco Calviani <marco.calviani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Information regarding C3 cpu state and bus mastering activity
Date: Mon, 12 Dec 2005 10:22:10 +0100
Message-ID: <da5cd1900512120122y217541a2h@mail.gmail.com>
References: <da5cd1900512111210k626ff691x@mail.gmail.com>
	 <439CC549.5060500@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <439CC549.5060500-cGBD8117FJM@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Hi list,

2005/12/12, Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>:

> No this is not Possibe. In C3 the processor disables his cache. If you
> have busmaster activity, there are direct writes into the cache (if I
> remeber right). So if you allow C3 and Busmaster, you will get into some
> serious truble and loose data.

Is this an hardware limitation or a software one?
If i understood well this occur because the active bus polling that is
required to maintain communication with usb devices deny the CPU from
switching to C3, and even if there are no usb device connected but the
modules are loaded the polling prevent the switch.
Will it be possible to increase the polling time, so that maybe the
CPU can enter that state?

Regards,
Marco Calviani


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
