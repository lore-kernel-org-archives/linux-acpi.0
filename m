From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fw: ACPI, pm timer and ASUS a8v
Date: Wed, 21 Sep 2005 16:09:53 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F1784E83@pdsmsx406>
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

How about add something like this:
if (fadt->revision >=3D FADT2_REVISION_ID) {
		/* FADT rev. 2 */
		if (fadt->xpm_tmr_blk.address_space_id !=3D
ACPI_ADR_SPACE_SYSTEM_IO)
			return 0;

		pmtmr_ioport =3D fadt->xpm_tmr_blk.address;
+		if (!pmtmr_ioport)
+			pmtmr_ioport =3D fadt->V1_pm_tmr_blk;
	} else {
		/* FADT rev. 1 */
		pmtmr_ioport =3D fadt->V1_pm_tmr_blk;
	}


>-----Original Message-----
>From: Jonas Oreland [mailto:jonas-fAbYwIrWRvUAvxtiuMwx3w@public.gmane.org]
>Sent: Wednesday, September 21, 2005 3:44 PM
>To: Li, Shaohua
>Cc: Andrew Morton; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Fw: ACPI, pm timer and ASUS a8v
>
>Li, Shaohua wrote:
>> Hi Jonas,
>> What the dmesg in the failure case? It seems the attched dmesg has
the
>> correct pm-timer info.
>
>yes, this is the "my own hardcoded" version.
>
>attaching one from failure case.
>
>thank you for looking at it.
>
>/Jonas
>
>>
>> Thanks,
>> Shaohua
>>
>>
>>>-----Original Message-----
>>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andrew Morton
>>>Sent: Wednesday, September 21, 2005 2:18 PM
>>>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>>Cc: Jonas Oreland
>>>Subject: [ACPI] Fw: ACPI, pm timer and ASUS a8v
>>>
>>>
>>>Jonas, you'll probably need to raise an ACPi report at
>>
>> bugzilla.kernel.org
>>
>>>for this one please.
>>>
>>>Begin forwarded message:
>>>
>>>Date: Tue, 20 Sep 2005 14:12:53 +0200
>>>From: Jonas Oreland <jonas-fAbYwIrWRvUAvxtiuMwx3w@public.gmane.org>
>>>To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>Subject: ACPI, pm timer and ASUS a8v
>>>
>>>
>>>Hi,
>>>
>>>I running 2.6.12-gentoo-r10
>>>I have a ASUS a8v motherboard with a AMD64 X2
>>>
>>>This gives me problem with clock drift
>>>(see http://bugzilla.kernel.org/show_bug.cgi?id=3D5105)
>>>
>>>So I tried using notsc to force usage of pm timer.
>>>
>>>But!
>>>The the acpi code find the fadt->xpm_tmr_blk.address to 0
>>>Making the code yet again fall back to PIT/TSC
>>>
>>>I booted my system can run
>>>perch> grep PM_ /proc/ioports
>>>0808-080b : PM_TMR
>>>
>>>And harded the address 0x808 into pmtmr_ioport
>>>This works. The system is using pmtmr and I get no clock drift
>>>(tested now for ~a day)
>>>
>>>But why do ACPI find 0 as pmtmr_ioport?
>>>
>>>/Jonas
>>
>>
>>



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
