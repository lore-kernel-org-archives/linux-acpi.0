From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: generic hotkey driver
Date: Wed, 8 Sep 2004 23:42:09 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84056F2BF9@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=20
>> We don't need to care about the format of event. Since it is
>> configurable,
>> we just need to understand the internal meaning. So maybe we
>> need to define the internal event number, which stands for a
>> special purpose. such as:
>>=20
>> 	001	turn off display
>> 	002	inc brightness
>> 	003	dec brightness
>> 	004	s3
>> 	......
>
>Hmm, ASUS laptops support some 16 distinct events, I don't see your
>solution maintainable.
>

Hmm, I will maintain a table internally, which will keep the mapping
between
the raw event value with the standard internal event num. If the raw
event value
cannot be mapped to any known standard event num, then the user can
treat=20
it as extended event. The entry could be:

struct raw_value_2_event {
	int	raw_event_number;
	int	standard_event;
	int	raw_event_flags;
	ACTION_LIST	*AML_METHOD;
}

The user or init script can input the mapping against the actual laptop
through
the interface:
/proc/acpi/hotkey/config/raw_event_mapping

To register expected acpi_handle which is needed to install
notify handler, which will generate event through /proc/acpi/event for
acpid.
we can input AML pathname on which driver will generate event
when get notified in AML method, like Notify( VGA, 0x80), through=20

/proc/acpi/hotkey/config/bus_notify

To register polling methods which will generate pseudo event, we can
input the expected AML methods pathname through
/proc/acpi/hotkey/config/pulling_method

Each successful pull will generate a event through /proc/acpi/event to
notify user land to get pulling data from /proc/acpi/hotkey/pulling_data
And the userland daemon will interpret the actual meaning of the raw
data.

To register the AML methods that should be executed , with
respect to  the hotkey get pressed. we can input AML pathname through
/proc/acpi/hotkey/config/event_action.

When userland daemon received a event, the daemon just need to feed
/proc/acpi/hotkey/action_argument with the proper argument string.
A "" means no argument is need for the method.

This is just a rough idea.=20

Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
