From: Gunter Ohrner <G.Ohrner-6V9naDJErT6662+jY7v6MhvVK+yQ3ZXh@public.gmane.org>
Subject: Re: no event for /proc/acpi/event with acpi
Date: Tue, 31 May 2005 20:52:31 +0200
Message-ID: <200505312052.33319.G.Ohrner@post.rwth-aachen.de>
References: <IHCYT6$A65ACB979DE9F2ADC9B481D1CAADB66A@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <IHCYT6$A65ACB979DE9F2ADC9B481D1CAADB66A-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Dienstag 31 Mai 2005 16:27 schrieb xavier.sinecosa:
> The file /proc/acpi/event can been accessed only once.
> When acpid runs,
> # cat /proc/acpi/event
> acpid: can't open /proc/acpi/event: Device or resource
> busy

Looks ok, acpid is blocking it.

> Stoping acpid, and cat'ing /proc/acpi/event, I get
> # cat /proc/acpi/event
>
> ....

Looks ok, it waits for an event. Execute this command and try pressind th=
e=20
power or suspend button or (un)plugging the ac adapter. The event should=20
show up.

> It stays like this. In another console I try acpid and
> get :
> # acpid
> acpid: can't open /proc/acpi/event: Device or resource
> busy
> #

This seems also ok, the cat is blocking access to the file.


Greetings,

  Gunter

--=20
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ http://aachen.uni-dsl.de/   -   Der direkte Draht in's Hochschulnetz! +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
- "Remember -- that which does not kill us can only make us stronger."
- "And that which *does* kill us leaves us *dead*!"
        -- (Terry Pratchett, Carpe Jugulum)
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                   PGP-verschl=FCsselte Mails bevorzugt!                =
 +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
