From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Battery information not showed
Date: Mon, 6 Sep 2004 15:24:36 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750F77A4@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?David_G=F3mez?= <david-0d+f1cuTMnnk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

David G=F3mez wrote:
>Subject: [ACPI] Battery information not showed
>
>Hi all,
>
>I'm trying to configure ACPI in my laptop, and it seems to work (acpid
>get power button, lid, sleep events). But not all the info is displayed
>in /proc/acpi. Mainly i'm interested in battery (or i'll never know =
when
>it runs out of stuff ;)). For instance, acpi command only shows thermal
>information:
>
>[huma@miller] [~] % acpi -V
>      Thermal 1: ok, 55.0 degrees C
>[huma@miller] [~] %
>
>And /proc/acpi/battery has no files inside it
>
>Laptop is and Acer Travelmate 4001LMi.
>
>Attached is the output of dmesg| grep ACPI. As i suppose for other
>people posts to the list, it should detect the battery and ac-adapter =
at
>boot, but it seems to be able to 'see' only fans, thermal and buttons
>information.
Can you say battery info in Windows? If yes, please send me the acpidmp =
outplug.=20

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
