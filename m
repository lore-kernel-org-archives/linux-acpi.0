From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake howto was: RE: [BKPATCH] ACPI for 2.6
Date: Thu, 01 Apr 2004 13:12:38 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr5rh3c2e4evsfm@smtp.pacific.net.th>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com> <20040330233155.463A.COUNT0@localnet.com> <opr5poqe0z4evsfm@smtp.pacific.net.th> <20040401003403.GA9382@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040401003403.GA9382-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 1 Apr 2004 02:34:03 +0200, Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org> wr=
ote:

> On Wed, Mar 31, 2004 at 01:40:52PM +0800, Michael Frank wrote:
>> On Tue, 30 Mar 2004 23:51:17 -0500, Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org> w=
rote:
>>
>> > [...]
>>
>> Nice writeup!, including the fact that it is too big for joe-helpout a=
nd
>> that a
>> team to handle the issues is lacking.
>>
>> Most PM issues are out of scope of ACPI CA.
>>
>> However I like to add that ACPI CA should implement a PM interface  fo=
r
>> ACPI  components to suspend/resume properly. Right now even AC adapter
>> must be made a module and reloaded after resume.
>>
>
> Are you sure you mean the ac adapter and not the battery module? For me
> the ac reports a wrong value if battery isn't unloaded on suspend and
> reloaded on resume. ac doesn't affect the problem.
>

Yes I am sure, I do not use the battery module at all, I only use AC and =
toshiba-acpi.

>> Michael


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
