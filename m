From: "Bjoern A. Zeeb" <bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org>
Subject: Re: [bug] endless loop in arch/i386/kernel/mpparse.c
Date: Mon, 30 Sep 2002 07:41:09 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.BSF.4.44.0209300723000.427-100000@e0-0.zab2.int.zabbadoz.net>
References: <20020929233532.H18377@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020929233532.H18377-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 29 Sep 2002, Matthew Wilcox wrote:

> If entry->header.length is zero without entry being equal to madt_end,
> this will loop for ever.  Maybe:
>
> [...]
> 			if (entry->header.length <= 0)
> 				break;

but is this really correct or does it simply hide the bug ?

> 			entry = (struct acpi_table_int_src_ovr *)
> 				((unsigned long) entry + entry->header.length);
> 		}
>
> is the right solution?


the other question: what is entry->header.length for the last entry
supposed to be ?  Should it be zero ?
Cause I think madt_end may hold the wrong value. (more down under).


> > [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070dc
> > [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070e4
> > [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070ec
> > [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d88070f8
> > [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d8807102
> > [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
> > [mpparse.c:mp_config_ioapic_for_sci:1047] madt_end=d8808080, entry=d880710c
>
> You can see that entry->header.length must be 0 at this point.  Probably a

yeah obviously.

> buggy MADT, but let's not _crash_ when the vendor provides a shit BIOS.

the other thing that I was thinking of is: entry is icremented by 8
but to reach madt_end we need to do another 494 increments. As I am
not really in that code I ask myself what is in that struct. If I
remember correctly 309 objects, ... were found; far not that much ...
(assumtion that we walk through them).
This, with the entry->header.length being zero I think (repeating
myself) madt_end may be wrong ?

I'll be off for the day now but going to pull and then check the
code in more detail esp. going back to drivers/acpi tracing
acpi_get_firmware_table().
Can anybody tell me when/where this list we walk through gets filled ?
Just to check what's coming in there ...


PS: I think on lkml in the "v2.6 vs v3.0" the posting from Murray J.
Root with answer from Zwane Mwaikambo may be related to this.
(for those to grep: original msg-id was: <20020929111918.GA1639-KLZTGNm03OFvpZiPlmaQFA@public.gmane.org>

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
