From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: problem with cpu eating too much power, prize given if solved
Date: Fri, 25 Jun 2004 01:40:04 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr930o2uv4evsfm@smtp.pacific.net.th>
References: <20040624153513.GB19545@rap.rap.dk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040624153513.GB19545-EittdKFJ/bZ/SzgSGea1oA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Keld_J=F8rn_Simonsen?= <keld-6PR53cSIHaE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 24 Jun 2004 17:35:13 +0200, Keld J=F8rn Simonsen <keld-6PR53cSIHaE@public.gmane.org> =
wrote:

> Dear ACPI developers,
>I have a problem with my Acer Travelmate 233.
>Many times I just want to read the screen, eg emails or documents,
> and then still the cpu will be in idle mode, where
> it uses 7.5 W out of the about 15 W that the whole machine uses.
> I have found out from Intel data sheets that my
> Mobile Intel Celeron 2.0 GHz CPU consumes 7.5 W in idle loop/
> stop grant/sleep states, (and 5.0 W i deep sleep state).
>So I would like to have the CPU stopped completely (consuming 0 W)
> while I still could read the screen. In that way I should
> be able to have about double the lifetime on the battery,
> going to about 7 hours from the 3.5 hours I have now.
>I would like the machine to wake up again by any keystroke
> on the keyboard or mouse input. I would like the input to be
> reacted upon (not just used to wake up the system, and
> then forgotten).
>I do not have the skills to program this myself, so
> instead I offer a prize of USD 1000 to the person(s) that
> can give me a patch for kernel 2.6 and appropiate documentation
> that can solve the above problem. The patch needs to be GPL,
> and demonstrably run on my laptop. I need the patch before
> 2004-10-01, after what date the prize offer expires.
>I would like that the patch was written in a general way to cover for
> CPUs that burn considerable power in idle loop and other states, so tha=
t
> other users can benefit from it. Also I would prefer that the patch be
> rolled into the normal ACPI kernel source tree, but the latter request
> is not a condition for the prize.
>

Nice idea but it wont be possible to program it as your hardware powers
the CPU which takes 5w while it is powered. There is no partitioning
which allows you to remove power from the CPU while running the rest
and I am not aware of any system or standards which provide this kind
of partitioning...

	Sorry
	Michael


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
