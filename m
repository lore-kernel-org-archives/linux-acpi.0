From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Re: DSDT Change (Compaq Presario 2100)
Date: Sat, 03 Jul 2004 18:08:37 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opsaj3snak4evsfm@smtp.pacific.net.th>
References: <200405280621.29874.andre@eisenbach.com> <c9am7j$nng$1@sea.gmane.org> <200405291345.51712.andre@eisenbach.com> <20040628213409.GA19468@elf.ucw.cz> <cbsi0v$t1r$1@sea.gmane.org> <20040702115454.GA12889@elf.ucw.cz> <40E59C64.9050603@eisenbach.com> <20040702192152.GB10138@elf.ucw.cz> <opsai7dgaq4evsfm@smtp.pacific.net.th> <20040703003713.GG3889@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040703003713.GG3889-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>, Erik Meitner <usenet-cuDg6iFcrsRAfugRpC6u6w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 3 Jul 2004 02:37:13 +0200, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Hi!
>
>> The AC adapter produces a voltage which gets stepped down in
>> the box to power the  bus to which battery and rest of system connect.
>>
>> The additional temperature rise can be explained by the additional
>> heat generated in this circutry or other than that, perhaps CPU core
>> voltage is increased when on AC accounting for the increase in
>> power consumption. Note that in this case your DSDT change
>> my run the CPU "too fast" for it's Vcore on battery...
>
> Increasing Vcore on AC when it can run on lower Vcore and same clock
> on battery would be pretty strange, no?

Considering the original system behavior, it is not strange at all.
IMO they have a simple implemententation of 2 Vcores and 2
frequencies and switch to the lower one one battery.

As it t would not make sense to reduce clock frequency without
reducing Vcore, my concern is that the "design change" increasing
the  frequency may have  unexpected side effects.

Thus right now the system seems "overclocked" on battery and
I suggest again to find a way to measure Vcore to be sure...






-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
