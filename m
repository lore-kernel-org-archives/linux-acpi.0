From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [RFT] hp-wmi: improved rfkill support for wifi
Date: Mon, 20 Jul 2009 21:08:41 +0100
Message-ID: <4A64CEC9.8020402@tuffmail.co.uk>
References: <4A61FE7D.9080409@tuffmail.co.uk>	 <8db1092f0907181155h3d603a17q11815b9f174ac333@mail.gmail.com>	 <4A623490.50305@tuffmail.co.uk>	 <8db1092f0907190028o334371d7g798c1e8cb9a5744b@mail.gmail.com>	 <4A635618.3070507@tuffmail.co.uk>	 <8db1092f0907191110p2d3c2c45je61bda6365ed1468@mail.gmail.com>	 <4A6364DF.3040303@tuffmail.co.uk>	 <8db1092f0907191208i6fcdf519r8204be542e95bbe4@mail.gmail.com>	 <4A64A50D.5040401@tuffmail.co.uk> <8db1092f0907201254m2be66477k6ec2f447bfad9f73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:41991 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbZGTUIr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jul 2009 16:08:47 -0400
In-Reply-To: <8db1092f0907201254m2be66477k6ec2f447bfad9f73@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, Frans Pop <elendil@planet.nl>, Larry Finger <Larry.Finger@lwfinger.net>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Maciej Rutecki wrote:
> 2009/7/20 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:
>  =20
>> ...and here's the version that remembers to register the bluetooth. =
 I
>> reviewed the patch again; hopefully that's the last dumb error.
>>    =20
> [...]
>
> 2.6.31-rc3+ patches:
> http://lkml.org/lkml/2009/7/18/131
> http://lkml.org/lkml/2009/7/10/339
> + patch below:
>
>  =20
>> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp=
-wmi.c
>> index 517ac47..adb26d3 100644
>> --- a/drivers/platform/x86/hp-wmi.c
>> +++ b/drivers/platform/x86/hp-wmi.c
>> @@ -51,6 +51,12 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C=
707E4");
>>  #define HPWMI_WIRELESS_QUERY 0x5
>>  #define HPWMI_HOTKEY_QUERY 0xc
>>
>> +enum hp_wmi_radio {
>> +       HPWMI_WIFI =3D 0,
>> +       HPWMI_BLUETOOTH =3D 1,
>> +       HPWMI_WWAN =3D 2,
>> +};
>> +
>>  static int __init hp_wmi_bios_setup(struct platform_device *device)=
;
>>  static int __exit hp_wmi_bios_remove(struct platform_device *device=
);
>>  static int hp_wmi_resume_handler(struct platform_device *device);
>> @@ -170,8 +176,8 @@ static int hp_wmi_tablet_state(void)
>>
>>  static int hp_wmi_set_block(void *data, bool blocked)
>>  {
>> -       unsigned long b =3D (unsigned long) data;
>> -       int query =3D BIT(b + 8) | ((!blocked) << b);
>> +       enum hp_wmi_radio r =3D (enum hp_wmi_radio) data;
>> +       int query =3D BIT(r + 8) | ((!blocked) << r);
>>
>>        return hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 1, query);
>>  }
>> @@ -180,41 +186,23 @@ static const struct rfkill_ops hp_wmi_rfkill_o=
ps =3D {
>>        .set_block =3D hp_wmi_set_block,
>>  };
>>
>> -static bool hp_wmi_wifi_sw_state(void)
>> +static bool hp_wmi_get_sw_state(enum hp_wmi_radio r)
>>  {
>>        int wireless =3D hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0=
, 0);
>> +       int mask =3D 0x200 << (r * 8);
>>
>> -       if (wireless & 0x200)
>> +       if (wireless & mask)
>>                return false;
>>        else
>>                return true;
>>  }
>>
>> -static bool hp_wmi_wifi_hw_state(void)
>> +static bool hp_wmi_get_hw_state(enum hp_wmi_radio r)
>>  {
>>        int wireless =3D hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0=
, 0);
>> +       int mask =3D 0x800 << (r * 8);
>>
>> -       if (wireless & 0x800)
>> -               return false;
>> -       else
>> -               return true;
>> -}
>> -
>> -static bool hp_wmi_bluetooth_state(void)
>> -{
>> -       int wireless =3D hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, =
0, 0);
>> -
>> -       if (wireless & 0x10000)
>> -               return false;
>> -       else
>> -               return true;
>> -}
>> -
>> -static bool hp_wmi_wwan_state(void)
>> -{
>> -       int wireless =3D hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, =
0, 0);
>> -
>> -       if (wireless & 0x1000000)
>> +       if (wireless & mask)
>>                return false;
>>        else
>>                return true;
>> @@ -339,50 +327,55 @@ static void hp_wmi_notify(u32 value, void *con=
text)
>>        struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL =
};
>>        static struct key_entry *key;
>>        union acpi_object *obj;
>> +       int eventcode;
>>
>>        wmi_get_event_data(value, &response);
>>
>>        obj =3D (union acpi_object *)response.pointer;
>>
>> -       if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER && obj->buffer.=
length =3D=3D 8) {
>> -               int eventcode =3D *((u8 *) obj->buffer.pointer);
>> -               if (eventcode =3D=3D 0x4)
>> -                       eventcode =3D hp_wmi_perform_query(HPWMI_HOT=
KEY_QUERY, 0,
>> -                                                        0);
>> -               key =3D hp_wmi_get_entry_by_scancode(eventcode);
>> -               if (key) {
>> -                       switch (key->type) {
>> -                       case KE_KEY:
>> -                               input_report_key(hp_wmi_input_dev,
>> -                                                key->keycode, 1);
>> -                               input_sync(hp_wmi_input_dev);
>> -                               input_report_key(hp_wmi_input_dev,
>> -                                                key->keycode, 0);
>> -                               input_sync(hp_wmi_input_dev);
>> -                               break;
>> -                       }
>> -               } else if (eventcode =3D=3D 0x1) {
>> -                       input_report_switch(hp_wmi_input_dev, SW_DOC=
K,
>> -                                           hp_wmi_dock_state());
>> -                       input_report_switch(hp_wmi_input_dev, SW_TAB=
LET_MODE,
>> -                                           hp_wmi_tablet_state());
>> +       if (!obj || obj->type !=3D ACPI_TYPE_BUFFER || obj->buffer.l=
ength !=3D 8) {
>> +               printk(KERN_INFO "HP WMI: Unknown response received\=
n");
>> +               return;
>> +       }
>> +
>> +       eventcode =3D *((u8 *) obj->buffer.pointer);
>> +       if (eventcode =3D=3D 0x4)
>> +               eventcode =3D hp_wmi_perform_query(HPWMI_HOTKEY_QUER=
Y, 0,
>> +                                               0);
>> +       key =3D hp_wmi_get_entry_by_scancode(eventcode);
>> +       if (key) {
>> +               switch (key->type) {
>> +               case KE_KEY:
>> +                       input_report_key(hp_wmi_input_dev,
>> +                                        key->keycode, 1);
>> +                       input_sync(hp_wmi_input_dev);
>> +                       input_report_key(hp_wmi_input_dev,
>> +                                        key->keycode, 0);
>>                        input_sync(hp_wmi_input_dev);
>> -               } else if (eventcode =3D=3D 0x5) {
>> -                       if (wifi_rfkill)
>> -                               rfkill_set_states(wifi_rfkill,
>> -                                                 hp_wmi_wifi_sw_sta=
te(),
>> -                                                 hp_wmi_wifi_hw_sta=
te());
>> -                       if (bluetooth_rfkill)
>> -                               rfkill_set_sw_state(bluetooth_rfkill=
,
>> -                                                   hp_wmi_bluetooth=
_state());
>> -                       if (wwan_rfkill)
>> -                               rfkill_set_sw_state(wwan_rfkill,
>> -                                                   hp_wmi_wwan_stat=
e());
>> -               } else
>> -                       printk(KERN_INFO "HP WMI: Unknown key presse=
d - %x\n",
>> -                              eventcode);
>> +                       break;
>> +               }
>> +       } else if (eventcode =3D=3D 0x1) {
>> +               input_report_switch(hp_wmi_input_dev, SW_DOCK,
>> +                                   hp_wmi_dock_state());
>> +               input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE=
,
>> +                                   hp_wmi_tablet_state());
>> +               input_sync(hp_wmi_input_dev);
>> +       } else if (eventcode =3D=3D 0x5) {
>> +               if (wifi_rfkill)
>> +                       rfkill_set_states(wifi_rfkill,
>> +                                         hp_wmi_get_sw_state(HPWMI_=
WIFI),
>> +                                         hp_wmi_get_hw_state(HPWMI_=
WIFI));
>> +               if (bluetooth_rfkill)
>> +                       rfkill_set_states(bluetooth_rfkill,
>> +                                         hp_wmi_get_sw_state(HPWMI_=
BLUETOOTH),
>> +                                         hp_wmi_get_hw_state(HPWMI_=
BLUETOOTH));
>> +               if (wwan_rfkill)
>> +                       rfkill_set_states(wwan_rfkill,
>> +                                         hp_wmi_get_sw_state(HPWMI_=
WWAN),
>> +                                         hp_wmi_get_hw_state(HPWMI_=
WWAN));
>>        } else
>> -               printk(KERN_INFO "HP WMI: Unknown response received\=
n");
>> +               printk(KERN_INFO "HP WMI: Unknown key pressed - %x\n=
",
>> +                       eventcode);
>>  }
>>
>>  static int __init hp_wmi_input_setup(void)
>> @@ -461,11 +454,11 @@ static int __init hp_wmi_bios_setup(struct pla=
tform_device *device)
>>                wifi_rfkill =3D rfkill_alloc("hp-wifi", &device->dev,
>>                                           RFKILL_TYPE_WLAN,
>>                                           &hp_wmi_rfkill_ops,
>> -                                          (void *) 0);
>> +                                          (void *) HPWMI_WIFI);
>>                rfkill_init_sw_state(wifi_rfkill,
>> -                                    hp_wmi_wifi_sw_state());
>> +                                    hp_wmi_get_sw_state(HPWMI_WIFI)=
);
>>                rfkill_set_hw_state(wifi_rfkill,
>> -                                   hp_wmi_wifi_hw_state());
>> +                                   hp_wmi_get_hw_state(HPWMI_WIFI))=
;
>>                err =3D rfkill_register(wifi_rfkill);
>>                if (err)
>>                        goto register_wifi_error;
>> @@ -475,7 +468,11 @@ static int __init hp_wmi_bios_setup(struct plat=
form_device *device)
>>                bluetooth_rfkill =3D rfkill_alloc("hp-bluetooth", &de=
vice->dev,
>>                                                RFKILL_TYPE_BLUETOOTH=
,
>>                                                &hp_wmi_rfkill_ops,
>> -                                               (void *) 1);
>> +                                               (void *) HPWMI_BLUET=
OOTH);
>> +               rfkill_init_sw_state(bluetooth_rfkill,
>> +                                    hp_wmi_get_sw_state(HPWMI_BLUET=
OOTH));
>> +               rfkill_set_hw_state(bluetooth_rfkill,
>> +                                   hp_wmi_get_hw_state(HPWMI_BLUETO=
OTH));
>>                err =3D rfkill_register(bluetooth_rfkill);
>>                if (err)
>>                        goto register_bluetooth_error;
>> @@ -485,7 +482,11 @@ static int __init hp_wmi_bios_setup(struct plat=
form_device *device)
>>                wwan_rfkill =3D rfkill_alloc("hp-wwan", &device->dev,
>>                                           RFKILL_TYPE_WWAN,
>>                                           &hp_wmi_rfkill_ops,
>> -                                          (void *) 2);
>> +                                          (void *) HPWMI_WWAN);
>> +               rfkill_init_sw_state(wwan_rfkill,
>> +                                    hp_wmi_get_sw_state(HPWMI_WWAN)=
);
>> +               rfkill_set_hw_state(wwan_rfkill,
>> +                                   hp_wmi_get_hw_state(HPWMI_WWAN))=
;
>>                err =3D rfkill_register(wwan_rfkill);
>>                if (err)
>>                        goto register_wwan_err;
>> @@ -541,9 +542,18 @@ static int hp_wmi_resume_handler(struct platfor=
m_device *device)
>>                            hp_wmi_tablet_state());
>>        input_sync(hp_wmi_input_dev);
>>
>> -       rfkill_set_states(wifi_rfkill,
>> -                         hp_wmi_wifi_sw_state(),
>> -                         hp_wmi_wifi_hw_state());
>> +       if (wifi_rfkill)
>> +               rfkill_set_states(wifi_rfkill,
>> +                                 hp_wmi_get_sw_state(HPWMI_WIFI),
>> +                                 hp_wmi_get_hw_state(HPWMI_WIFI));
>> +       if (bluetooth_rfkill)
>> +               rfkill_set_states(bluetooth_rfkill,
>> +                                 hp_wmi_get_sw_state(HPWMI_BLUETOOT=
H),
>> +                                 hp_wmi_get_hw_state(HPWMI_BLUETOOT=
H));
>> +       if (wwan_rfkill)
>> +               rfkill_set_states(wwan_rfkill,
>> +                                 hp_wmi_get_sw_state(HPWMI_WWAN),
>> +                                 hp_wmi_get_hw_state(HPWMI_WWAN));
>>
>>        return 0;
>>  }
>>
>>
>>
>>    =20
>
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
> 0: phy0: Wireless LAN
>         Soft blocked: yes
>         Hard blocked: yes
> 1: hp-wifi: Wireless LAN
>         Soft blocked: yes
>         Hard blocked: no
> 2: hp-bluetooth: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill unblock 0
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
> 0: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: yes
> 1: hp-wifi: Wireless LAN
>         Soft blocked: yes
>         Hard blocked: no
> 2: hp-bluetooth: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill unblock 1
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
> 0: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 1: hp-wifi: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 2: hp-bluetooth: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill unblock 2
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
> 0: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 1: hp-wifi: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 2: hp-bluetooth: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 3: hci0: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill unblock 3
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# ./rfkill list
> 0: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 1: hp-wifi: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 2: hp-bluetooth: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 3: hci0: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> root@gumis:/home/maciek/zrodelka/rfkill/rfkill# hciconfig
> hci0:   Type: USB
>         BD Address: 00:16:41:88:A0:1B ACL MTU: 1017:8 SCO MTU: 64:8
>         DOWN
>         RX bytes:318 acl:0 sco:0 events:6 errors:0
>         TX bytes:27 acl:0 sco:0 commands:9 errors:0
>
> Works OK. Thanks :-)
>
> During compile I have got:
> CC [M]  drivers/platform/x86/hp-wmi.o
> drivers/platform/x86/hp-wmi.c: In function =E2=80=98hp_wmi_bios_setup=
=E2=80=99:
> drivers/platform/x86/hp-wmi.c:460: warning: ignoring return value of
> =E2=80=98rfkill_set_hw_state=E2=80=99, declared with attribute warn_u=
nused_result
> drivers/platform/x86/hp-wmi.c:474: warning: ignoring return value of
> =E2=80=98rfkill_set_hw_state=E2=80=99, declared with attribute warn_u=
nused_result
> drivers/platform/x86/hp-wmi.c:488: warning: ignoring return value of
> =E2=80=98rfkill_set_hw_state=E2=80=99, declared with attribute warn_u=
nused_result
>  =20

The attribute is wrong, I've already submitted a patch to remove it.

I'll combine this patch with the previous one and submit it tomorrow.

Thanks again
Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
