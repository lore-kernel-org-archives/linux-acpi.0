From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fw: ACPI, pm timer and ASUS a8v
Date: Wed, 21 Sep 2005 16:23:13 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F1784EB5@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Jonas Oreland <jonas-fAbYwIrWRvUAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> How about add something like this:
>> if (fadt->revision >=3D FADT2_REVISION_ID) {
>> 		/* FADT rev. 2 */
>> 		if (fadt->xpm_tmr_blk.address_space_id !=3D
>> ACPI_ADR_SPACE_SYSTEM_IO)
>> 			return 0;
>>
>> 		pmtmr_ioport =3D fadt->xpm_tmr_blk.address;
>> +		if (!pmtmr_ioport)
>> +			pmtmr_ioport =3D fadt->V1_pm_tmr_blk;
>> 	} else {
>> 		/* FADT rev. 1 */
>> 		pmtmr_ioport =3D fadt->V1_pm_tmr_blk;
>> 	}
>
>this works
Great.

>
>ps.
>	I opened as andrew suggested a bug report:
>http://bugzilla.kernel.org/show_bug.cgi?id=3D5283
>ds.
Ok, I'll attach a formal patch into bugzilla.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
