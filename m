From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: RE: Re: [PATCH] S4bios for 2.5.52.
Date: Fri, 20 Dec 2002 09:04:47 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000701c2a79a$04084c10$0101010a@NigelLaptop>
References: <B900970C7DD9474C972986EB3EC7C58F0D404E@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0008_01C2A806.FB019410"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <B900970C7DD9474C972986EB3EC7C58F0D404E-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Herbert Nachtnebel' <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C2A806.FB019410
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I don't think so, because AFAIK the bdflush daemon is in the refrigerator by
this point and it is consistently when a particular page number is submitted
that the first 'flush' occurs. I thought it might be that some threshhold is
reached. Oh - just in case there's anyone wondering, I'm not trying to write
to anything other than an IDE swap partition :>

Regards,

Nigel

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Herbert
> Nachtnebel
> Sent: Thursday, December 19, 2002 10:49 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: AW: [ACPI] Re: [PATCH] S4bios for 2.5.52.
>
>
> Sorry to be stupid,
>
> but that sounds like a unpluged block queue which get flushed
> every 5 seconds (or 30 seconds) by the bdflush daemon. There
> are two things which counters this, 1st: swsusp works on ide
> and there aren't such problems since aeons and 2nd Pavel
> knows that :-)
> Hence, apologies for this hip shot.
>
> Herbert.
>

------=_NextPart_000_0008_01C2A806.FB019410
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
RDhFMzM0NjEwOTdEOTg0MUYyNzAwAAAAABAB

------=_NextPart_000_0008_01C2A806.FB019410--



-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
