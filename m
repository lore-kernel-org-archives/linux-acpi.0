From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: AW: Re: [PATCH] S4bios for 2.5.52.
Date: Thu, 19 Dec 2002 10:49:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F0D404E@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sorry to be stupid,=20

but that sounds like a unpluged block queue which get flushed every 5 =
seconds (or 30 seconds) by the bdflush daemon. There are two things =
which counters this, 1st: swsusp works on ide and there aren't such =
problems since aeons and 2nd Pavel knows that :-)
Hence, apologies for this hip shot.

Herbert.

-----Urspr=FCngliche Nachricht-----
Von: Nigel Cunningham [mailto:ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org]
Gesendet: Mittwoch, 18. Dezember 2002 20:38
An: 'Ducrot Bruno'; 'Kai Germaschewski'
Cc: 'Grover, Andrew'; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 'Pavel Machek';
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Betreff: RE: [ACPI] Re: [PATCH] S4bios for 2.5.52.


> Kai, if you see that S4OS is slower, it is probably a bug
> that have to be
> fixed in swsusp.

There does seem to be a problem with the rw_swap_page_sync routine. =
Perhaps
not on Pavel's machine (:>), but I've experienced painfully slow =
suspends
too. Performance was helped immensely by applying a concept that I'll =
credit
Lyle Seaman for - unrolling rw_swap_page_sync and submitting all the IO =
for
pages then looping again and waiting on each sync. I found with writing =
7000
or so pages (a suspend from init S) that something gets triggered to =
force
the sync about every 3900 pages anyway.

Regards,

Nigel



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
