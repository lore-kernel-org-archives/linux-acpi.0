From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: kacpid problems
Date: Mon, 8 Nov 2004 11:23:53 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC02D@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Cc: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'd like to see your box's DSDT to have a idea of what's going on in =
your box.

Thanks
Luming=20

>-----Original Message-----
>From: Laszlo 'GCS' Boszormenyi [mailto:gcs-gKC9iF2I70U@public.gmane.org]=20
>Sent: 2004=C4=EA11=D4=C28=C8=D5 11:18
>To: Yu, Luming
>Cc: dev_zero; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] kacpid problems
>
>* Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org> [2004-11-08 03:48:59 +0100]:
>
>> > Could you verify if killing kacpid can make the thing better?
>>  This just happened to me again. I did /etc/init.d/acpid stop, and it
>> did, but issuing halt left me with the acpi_power_off called message.
>> I think some memory corruption may happen in kernel space,=20
>or it is just
>> ACPI failing for some reason.
> OK, just happened again, so update: I did /etc/init.d/acpid stop; but
>as I saw CPU usage went to half kernel space, half user space. But(!)
>now I can confirm that kacpid with pid 5 stuck in a D state,=20
>tried to do
>something, but the box was so crawling that I chose to pull=20
>out the cord
>instead.
>
>HTH,
>Laszlo
>
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
