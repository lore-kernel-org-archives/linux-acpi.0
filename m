From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Re: Re: ACPI: Battery information?
Date: Sun, 13 Jun 2004 03:07:45 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr9hwq7tu4evsfm@smtp.pacific.net.th>
References: <40C4FD27.7000805@users.xeroprj.org> <20040608092045.72e15c4c@tethys.solarsys.org> <20040608094707.GM13782@poupinou.org> <40C58F45.2040108@users.xeroprj.org> <20040608113456.GN13782@poupinou.org> <40C6319A.7080707@users.xeroprj.org> <20040609075401.GT13782@poupinou.org> <20040610164324.GA6919@message-id.gmane0305.slipkontur.de> <20040610211644.GF13782@poupinou.org> <20040611051031.GA5237@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040611051031.GA5237-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 11 Jun 2004 05:10:31 -0000, Stefan Seyfried <seife-T+3qhDtrTvAGi/V7VeuXEw@public.gmane.org=
kontur.de> wrote:

> On Thu, Jun 10, 2004 at 11:16:44PM +0200, Bruno Ducrot wrote:
>> On Thu, Jun 10, 2004 at 04:43:24PM -0000, Stefan Seyfried wrote:
>>
>> > Well, this works fine for me on a hp compaq nx5000 with 2 batteries.
>> > So i suspect the quality of your BIOS / DSDT is to blame.
>>
>> It work for me since 2 or 3 years at least.
>
> Ok, qouted wrong: Binary Xerroz's BIOS may be to blame.
>
>> > > So it's more likely a trouble somewhere in your DSDT, or a bug und=
er linux.
>> >
>> > As written above, it works for me under Linux.
>>
>> Fine.  And you assume then if it work for you, but not for others, the=
n the
>> AML is faulty?  Why?
>
> No, what i wanted to say was: it works for my small sample of about
> 5 Machines with multiple batteries. If there was this general bug which
> would prevent multiple batteries from working all the time i think i
> would have hit it, too.
> Of course there also can be a bug which is only triggered by some
> special machine.

... some special machine containing some special DSDT which is not
standards compliant...

AML tools are fairly mature and check DSTD well. IME at least half
of all DSTDs disassmbled some bugs, many minor, some major breaking
things.






-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
