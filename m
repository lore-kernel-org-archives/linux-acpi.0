From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Re: AC adapter status wrong after resume (swsusp, pmdsik)
Date: Sun, 28 Mar 2004 04:10:59 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr5jecleg4evsfm@smtp.pacific.net.th>
References: <20040322154654.GA10305@pern.dea.icai.upco.es> <20040322223145.GA2549@luna.mooo.com> <20040323090055.GA8857@message-id.gmane0305.slipkontur.de> <20040327195842.GB2737@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040327195842.GB2737-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 27 Mar 2004 21:58:42 +0200, Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org> w=
rote:

> On Tue, Mar 23, 2004 at 10:00:55AM +0100, Stefan Seyfried wrote:
>> On Tue, Mar 23, 2004 at 12:31:45AM +0200, Micha Feigin wrote:
>>
>> > >       Iam an user of linux 2.6.x on a Vaio FX701 laptop. I found a=
 little
>> > >       problem with AC charger status and the suspend/resume softwa=
re, and so
>> >
>> > I saw this same problem with swsusp2. The solution was to compile th=
e
>> > battery support as a module, unload it before suspend and reload it
>> > after resume.
>>
>> Well, of course this is a workaround, not a solution ;-)
>> Are you sure it's the battery and not the ac module? The reason i'm
>
> Yes, I tried first with the ac module since it looked more logical but
> that didn't effect things, doing the same with the battery module did
> help.
>
>> asking is: i have a similar problem and unloading / reloading modules
>> after suspend does not help, though i never tried unloading before
>> and reloading after suspend.
>> Since this seems to be a generic bug and not only on my hardware, i
>> will file a bug for it.
>
> Of course its a work around and not a solution, but if it solves things
> then it can help point at the problem, especially considering that it
> seems that the battery module affects the ac status in this case.
>
>

IME, all acpi modules except toshiba-acpi must be removed prior to suspen=
d.

The fundamental reason for the malfunction is that acpi modules do
not listen to PM events resulting in their (suspended) state on resume be=
ing
inonsistent with what the BIOS set prior to returning control (S3) / boot=
ing (S4).

Regards
Michael


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
