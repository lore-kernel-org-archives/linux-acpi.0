From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
Date: Wed, 20 Oct 2004 11:18:08 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405DCA922@pdsmsx403>
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
To: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Too many hard-code . :-(=20

I'm working on a generic hotkey driver, which will move configurable=20
stuff to user space.=20

 Basically, I will standardize hotkey event num dispatched to user space

through /proc/acpi/event.  And I will define config and action
interfaces
under /proc/acpi/hotkey to make the hotkey driver has unified interface=20
to user space daemon. :

ev_config: config interface for event based hotkey.

Format for config event based hotkey:
echo
"config_command:bus_handle:action_handle:internal_event_num:external_hot
key_num" > ev_config
For example:
1. add a new hotkey:
 echo "0 : _SB.VGA : _SB.VGA.LCD._BCM :0x86 : 0x86" >
/proc/acpi/ev_config
2. delete a hotkey config:
 echo "1: : : :0x86" > /proc/acpi/ev_config
3. update a hotkey config:
 echo "0 : _SB.VGA : _SB.VGA.CRT._BCM :0x87 : 0x87" >
/proc/acpi/ev_config

pl_config: config interface for polling based hotkey.
Format for config polling based hotkey:
 echo
"config_command:pollin_handle:action_handle:internal_event_num:external_
hotkey_num" > ev_config
For example:
1. add a new hotkey:
 echo "0 : _SB.VGA : _SB.POLLING_METHOD : _SB.ACTION_METHOD  : 0X86 :
0X86" > /proc/acpi/pl_config
2..=20

Action: action interface for acpid to call aml method related to the
hotkey event.=20
Format for calling aml method through action interface.
 echo "event_num: argument type : value"
For example:
 echo "0x86:1:30" > /proc/acpi/action

Thanks,
Luming

>-----Original Message-----
>From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
>[mailto:linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of=20
>Borislav Deianov
>Sent: Tuesday, October 19, 2004 2:00 PM
>To: Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org;=20
>linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
>
>Hi,
>
>This is a Linux ACPI driver for the IBM ThinkPad laptops. It aims to
>support various features of these laptops which are accessible through
>the ACPI framework but not otherwise supported by the generic Linux
>ACPI drivers.
>
>For more information, see http://ibm-acpi.sf.net/
>
>The attached patch is against 2.6.9-rc4-mm1.
>
>Boris
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
