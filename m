From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Re: DSDT Change (Compaq Presario 2100)
Date: Sat, 03 Jul 2004 06:28:18 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opsai7dgaq4evsfm@smtp.pacific.net.th>
References: <200405280621.29874.andre@eisenbach.com> <c9am7j$nng$1@sea.gmane.org> <200405291345.51712.andre@eisenbach.com> <20040628213409.GA19468@elf.ucw.cz> <cbsi0v$t1r$1@sea.gmane.org> <20040702115454.GA12889@elf.ucw.cz> <40E59C64.9050603@eisenbach.com> <20040702192152.GB10138@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040702192152.GB10138-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: Erik Meitner <usenet-cuDg6iFcrsRAfugRpC6u6w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2 Jul 2004 21:21:52 +0200, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Hi!
>
>> Thanks for the heads up on this, Pavel!
>>
>> I did unplug my batter, started an updatedb and compiled firefox,
>> coreutils and a new kernel. The battery got warm, but not hot.
>> Definitely not more then when charging it.
>>
>> A curious (unrelated) observation:
>> The ACPI thermal zone temperature indicated about 68 C at most  on
>> battery doing this. However, when the battery was drained and I plugge=
d
>> the AC back in, the temperature rose and stayed at about 75 C and the
>> fans worked audibly harder. This continued even after I removed the
>> battery, so it's not the additional heat from the charging.
>> I wonder if something else is throttled when on battery. It's not the
>> CPU though as benchmarks dont slow down on battery anymore after my DS=
DT
>> change.
>
> Strange... It could be backlight, but that does not produce enough
> heat...
>

The AC adapter produces a voltage which gets stepped down in
the box to power the  bus to which battery and rest of system connect.

The additional temperature rise can be explained by the additional
heat generated in this circutry or other than that, perhaps CPU core
voltage is increased when on AC accounting for the increase in
power consumption. Note that in this case your DSDT change
my run the CPU "too fast" for it's Vcore on battery...

The only way to find out is to measure Vcore - is there a means in the BI=
OS?

=09





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
