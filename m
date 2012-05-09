From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Resend PATCH V2 3/7] usb: Set device removable state based on
 ACPI USB data
Date: Wed, 09 May 2012 09:00:10 +0800
Message-ID: <4FA9C19A.2020800@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-4-git-send-email-tianyu.lan@intel.com> <201205040824.17010.oneukum@suse.de> <4FA72787.5000106@intel.com> <20120507165744.GA28045@kroah.com> <20120508025817.GB23448@srcf.ucam.org> <4FA8DEC9.7010603@intel.com> <4FA980C9.4020107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA980C9.4020107-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks, len and Bob. You are right. You make my explain more clear.
=E4=BA=8E2012=E5=B9=B405=E6=9C=8809=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=B8=89=
 04=E6=97=B623=E5=88=8637=E7=A7=92,Len Brown=E5=86=99=E5=88=B0:
> On 05/08/2012 04:52 AM, Lan Tianyu wrote:
>
>> Hi all:
>>
>> Following is the usb port descriptor in the DSDT of Thinkpad T410.
>> The port is attached with bluetooth on the board.
>
>
>>   Name (_UPC, Package (0x04) { 0xFF, 0xFF, 0x00, 0x00 })
>
>
> _UPC 1st byte says "connectable"
> _UPC 2nd byte says "proprietary connector"
>
>
>   Name (_PLD, Buffer (0x10)
>> { /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>    /* 0008 */    0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
>>                             })                           }
>> _PLD buffer show the device internal port.     Bit 64 =E2=80=93 User=
 Visible:
>> Set if the device connection point can be seen by the user without
>> disassembly.
>
>
> According to the decoding from Bob Moore,
> bit 64 is not set, and thus this I/F is NOT user visible.
> Are we decoding this correctly?
>
>      81 6:0 =3D 1 (revision)
>           7 =3D 1 (ignore color)
>      00 15:8 (color red =3D 0)
>      00 23:16 (color green =3D 0)
>      00 31:24 (color blue =3D 0)
>      00 47:32 (width =3D 0)
>      00
>      00 63:48 (Height =3D 0)
>      00
>      30 64 (user visible =3D 0)
>         65 (dock =3D 0)
>         66 (lid =3D 0)
>         67:69 (Panel =3D b110 =3D 6 =3D unknown)
>         71:70 (vertical =3D 0 =3D upper)
>      1c 73:72 (horizontal =3D b00 =3D 0 =3D left)
>         77:74 (shape =3D b0111 =3D 7 =3D unknown)
>      00
>      00
>      00
>      00
>      00
>      00
>
>
> -Len
>
>
>>
>> =E4=BA=8E2012=E5=B9=B405=E6=9C=8808=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=BA=
=8C 10=E6=97=B658=E5=88=8617=E7=A7=92,Matthew Garrett=E5=86=99=E5=88=B0=
:
>>> On Mon, May 07, 2012 at 09:57:44AM -0700, Greg KH wrote:
>>>> On Mon, May 07, 2012 at 09:38:15AM +0800, Lan Tianyu wrote:
>>>>> This depends on the bios. From my opinion, the bluetooth is devic=
e
>>>>> on the
>>>>> motherboard so it belongs to hard-wired type.
>>>>
>>>> That's nice, but it's not what is happening in lots of different l=
aptops
>>>> out there today.
>>>>
>>>> Oliver is right, how does this handle bluetooth USB controllers th=
at are
>>>> turned on/off from magic function-key presses?
>>>
>>> I /believe/ that such devices will be indicated as fixed rather tha=
n
>>> removable. The variable indicates the physical state rather than th=
e
>>> logical one - fixed doesn't mean that a device will never go away, =
it
>>> means that a user can't physically unplug it.
>>>
>>
>>
>>
>
>



--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
