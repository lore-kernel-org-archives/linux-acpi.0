From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 09:37:01 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20

>-----Original Message-----
>From: Richard Hughes [mailto:hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]=20
>Sent: 2006=C4=EA1=D4=C29=C8=D5 9:22
>To: Yu, Luming
>Cc: Matthew Garrett; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;=20
>gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org; hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org;=20
>desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
>Subject: Re: [gpm] Untangling the sleep hotkey mess
>
>On Mon, 2006-01-09 at 09:10 +0800, Yu Luming wrote:
>> >  3. Use the new acpi kernel hotkeys stuff -- not that I=20
>really understand
>> >  the interface, nor how to use it correctly. Plus I'm not=20
>sure how much
>> >  of the vendor kernel modules can use this new interface,=20
>or if it's
>> >  suitable. It all seemed a bit fragile last time I looked.
>>=20
>> Please take a look at=20
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D5749
>>=20
>> There are some examples to use hotkey.c for specific laptops=20
>with dedicated
>> hotkey acpi device objects , and dedicated AML methods.
>> This patch: http://bugzilla.kernel.org/show_bug.cgi?id=3D5749#c3
>> can be used to replace sony_acpi.c
>>=20
>> This patch: http://bugzilla.kernel.org/show_bug.cgi?id=3D5749#c4
>> can be used to support brightness control for panasonic laptop.
>>=20
>> This patch: http://bugzilla.kernel.org/show_bug.cgi?id=3D5749#c5
>> can be used to support brighness contrl for ASUS laptop.
>>=20
>> Please notes, I will update these patch against len's=20
>testing tree, and=20
>> ask for inclusion.
>
>Why do we want to use the new hotkey stuff when we can just process al=
l
>the events in userspace using acpi events? The hotkey stuff seems
>overcomplicated and fragile in my opinion.
>
>Sending and receiving :::data:in:some::odd:format seems a=20
>little unusual
>to me when we can just listen for the event in one place (like HAL) --
>but then maybe I don't understand all the details. It's not=20
>like we will
>have different programs registering for different acpi button events,
>right?

The hotkey.c is NOT like what you said above.
It is used to support dedicated hotkey device and dedicated hotkey AML =
methods
that are used by ODM to implement hotkey function on their own laptops.
As for hotkey event, hotkey.c doesn't handle it yet. =20
And so-called event_num in hotkey.c are mainly used as a key for search=
ing and storing.
=20
>
>Richard.
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
