From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Re: [Swsusp-devel] swsusp and ac status
Date: Fri, 25 Jun 2004 19:29:51 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr95d71ln4evsfm@smtp.pacific.net.th>
References: <200406250701.i5P71GKC006204@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200406250701.i5P71GKC006204-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Software Suspend - Mailing Lists <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 25 Jun 2004 09:01:15 +0200, Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org> =
wrote:

>>
>> Please try:
>> rmmod AC
>> suspend/resume
>> modprobe AC
>>
>> It should be OK...
>
> It is NOT in my case. It is one of the first things I did. Now, just
> in case, I gave it another try, but it does not work.
>
> modprobe -r ac
> suspend
> unplug
> resume
> modprobe ac
>
> cat /proc/acpi/ac_adapter/C131/state
> state: on-line
>
> If now, after resuming, I plug and unplug the adapter...
>
> cat /proc/acpi/ac_adapter/C131/state
> state: off-line
>

Too bad, this implies that the AC module does not get reinitialized after
resume and I suspect that acpi core is broken on 2.6 in this regard.

I'll compile 2.6 and try it on my HW.

Perhaps the ACPI people could advise how to increase debug verbosity
to see what happens or if that can't be done, put some printks into AC
module to see what happens when the module is loaded on resume.

	Michael



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
