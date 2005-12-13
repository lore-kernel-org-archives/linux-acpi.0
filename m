From: Marco Calviani <marco.calviani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Information regarding C3 cpu state and bus mastering activity
Date: Tue, 13 Dec 2005 21:52:31 +0100
Message-ID: <da5cd1900512131252h3aeadd48r@mail.gmail.com>
References: <da5cd1900512111210k626ff691x@mail.gmail.com>
	 <439CC549.5060500@tzi.de>
	 <da5cd1900512120122y217541a2h@mail.gmail.com>
	 <439D726E.4020704@tzi.de>
	 <da5cd1900512120810v75dd8721t@mail.gmail.com>
	 <200512130208.jBD280VU003725@mail.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200512130208.jBD280VU003725-2ArO/UEyFsZWk0Htik3J/w@public.gmane.org>
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

2005/12/13, phutchis-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org <phutchis-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>:

> Might be OK, provided the USB host controller *can* be powered down
> *and* we won't need to wake up due to someone touching the USB mouse
> or keyboard :)

Well, in my case the keyboard is not the problem since i'm running a laptop=
....
Do you know how is possible to power down the usb controller?

I was googling on this problem and i've found a page from Microsoft
support center that describe the same problem (for W2K and ME) on that
OS  http://support.microsoft.com/default.aspx?scid=3DKB;EN-US;Q297045&
They provide this "solution" (as i anticipated some mails ago): "To
resolve this problem, increase the USB polling interval from one ms to
five ms. Then, the processor can enter a C3 power-saving state during
its inactivity and extend the battery life of the computer. To
increase this polling interval, add a registry entry that is dependent
upon the operating system"

Any hint on how to implement this, and do you think that this can
provide some help?

Best regards,
Marco Calviani


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
