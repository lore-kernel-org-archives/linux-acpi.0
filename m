From: Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>
Subject: Re: Re: K7 & cpu disconnect
Date: Thu, 22 Jan 2004 12:06:48 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GHP.4.44.0401221200230.19210-100000@elektron.its.tudelft.nl>
References: <30489.1074762683@www25.gmx.net>
Reply-To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <30489.1074762683-F0zlgTPnfr9mcu3hnIyYJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Herrmann <ollo.diab-Mmb7MZpHnFY@public.gmane.org>
Cc: len-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Obviously I missed what led up to this message, but are you talking about
your box hanging under heavy io (badblocks, fsck, du etc)? I think most
nforce2 boards have this disconnect function in the bios. Anyway, my box
hangs under heavy io (abit nf7-s barton 2500+) under 2.4.23 with APIC in
the kernel, but not under 2.6.0-test11. In this kernel I have APIC
disabled. If you haven't done so, you kan check lkml archives for messages
by Ross Dickson, he brought this up there.

I think the 2.6.0-test11-mm tree has a patch cycled in with regards to
nforce2 (two actually) I can dig up the URL if you are interested.

Regards,

Arjen

On Thu, 22 Jan 2004, Thomas Herrmann wrote:

> Hi Len,
>
> one more data point wrt this topic.
>
> I can enable STPGNT/CPU disconnect on my NForce2 system running WinXP whi=
le
> using the tool from http://www.hasw.net/8rdavcore. And guess what, the sy=
stem
> runs stable for hours, not locking-up at all. Since this is exactly the s=
ame
> hardware as well as BIOS configuration, it leads me to beleave the Linux
> ACPI/IO_APIC implementation has an issue.
>
> BTW, it seems the acpi-devel list archive on sourceforge.net hangs, no ne=
w
> entries since 01/24/04.
>
> Regards,    Thomas
>
> --
> +++ GMX - die erste Adresse f=FCr Mail, Message, More +++
> Bis 31.1.: TopMail + Digicam f=FCr nur 29 EUR http://www.gmx.net/topmail
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
