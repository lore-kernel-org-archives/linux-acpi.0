From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Sat, 12 May 2012 00:12:01 +0800
Message-ID: <4FAD3A51.4010803@intel.com>
References: <Pine.LNX.4.44L0.1205101253280.1831-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39041 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760218Ab2EKQRV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 12:17:21 -0400
In-Reply-To: <Pine.LNX.4.44L0.1205101253280.1831-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

hi all:
	Great thanks for review.
On 2012=E5=B9=B405=E6=9C=8811=E6=97=A5 01:44, Alan Stern wrote:
> On Thu, 10 May 2012, Sarah Sharp wrote:
>
>> On Thu, May 10, 2012 at 11:54:04AM -0400, Alan Stern wrote:
>>> On Thu, 10 May 2012, Lan Tianyu wrote:
>>>
>>>> hi all:
>>>> 	Currently, we are working on usb port power off mechanism. Our de=
veloping
>>>> machine provides usb port power control (a vbus switch)via ACPI po=
wer resource.
>>>> When the power resource turns off, usb port powers off and usb dev=
ice loses
>>>> power. From usb hub side, just like the device being unplugged.
>>>>
>>>> 	Since usb port power off will affect hot-plug and devices remote =
wakeup
>>>> function, it should be careful to do that.
>>>> 	We conclude three different situations for power off mechanism.
>>>> 	(1) hard-wired port with device
>>>> 	(2) hot-pluggable port without device
>>>> 	(3) hot-pluggable port with device
>>>>
>>>> For hard-wired port, the device will not be removed physically. So=
 we can
>>>> power off it when device is suspended and remote wakeup is disable=
d without
>>>> concerning with hot-plug. This patch is dedicated to this siutatio=
n.
>>>>
>>>> This patch is to provide usb acpi power control method and call th=
em in the
>>>> usb_port_suspend() and usb_port_resume() when port can be power of=
f. When the
>>>> usb port is in the power off state, usb core doesn't remove device=
 which is
>>>> attached to the port. The device is still on the system and user c=
an access
>>>> the device.
>>>
>>> Can you provide any examples where this would be useful?  It won't =
end
>>> up saving very much power (although on a laptop even a little bit m=
ight
>>> help).
>>
>> Every little bit of power savings helps for the particular system th=
at
>> implements the USB port power off.  For this particular platform, In=
tel
>> is looking at the system as a whole and trying to eek out power savi=
ngs
>> where ever they can.  A little power savings in one particular subsy=
stem
>> may not seem like a big deal, but when you look at the overall pictu=
re,
>> the long tail adds up.  Just trust me, I'm excited about this system=
=2E :)
>
> I'll take your word for it.  :-)
>
    The power saving depends on devices. I test a usb3.0 ssd. The power=
 saving of
power off is about 2.2w more than just selective suspend. In theory, po=
wer
off can help to save remaining power after selective suspend.

>> As for examples of where the port power off would be useful, think a=
bout
>> a laptop with several internal ports.  The customer can save some mo=
ney
>> by choosing not to purchase an internal USB bluetooth device.  The O=
EM
>> may have just one motherboard for those two choices, so the port tha=
t
>> would have held the bluetooth device will be empty.  In that case, w=
e'll
>> never see a USB device connect on that empty port, so we may as well
>> power it down.  If we can further power off the internal webcam port
>> when the device is suspended, we can save more power.
>
> The patch did not address the case of powering down ports that have n=
o
> devices attached.  That might be a better place to start, because it'=
s
> simpler, even though it might not yield as much power savings.

Do you mean internal ports?
 From my opinion, ACPI will tell us whether the port is connectable or =
not.
When the internal port is not connectable, this means the port is not u=
sed
and this patch will power down the port.

@@ -55,9 +81,14 @@ static int usb_acpi_check_port_connect_type(struct u=
sb_device=20
*hdev,
                 pld.user_visible ?
                     USB_PORT_CONNECT_TYPE_HOT_PLUG :
                     USB_PORT_CONNECT_TYPE_HARD_WIRED);
-   else if (!pld.user_visible)
+   else if (!pld.user_visible) {
         usb_set_hub_port_connect_type(hdev, port1, USB_PORT_NOT_USED);

+       /* Power off the usb port which may not be used.*/
+       if (usb_acpi_power_manageable(hdev, port1))
+           usb_acpi_set_power_state(hdev, port1, false);
+   }
+

=46or external ports, this should be associated with sys file control. =
The users
need to determine when they should be power off.

So I should work on the external ports without devices firstly and
add the sys file for user to control?

>
> There's one more thing to consider, which was missing from the patch.
> When you power the port back up and resume the device, it will
> necessarily be a reset-resume.  You won't want to do this if any of t=
he
> drivers attached to the device's interfaces doesn't have reset-resume
> support.
>
>> Another example is when a user walks away from their laptop with som=
e
>> USB devices plugged in.  If userspace can somehow know when the syst=
em
>> is idle (e.g. the screen blanks, the bluetooth/NFC radio no longer
>> detects the person's phone, etc), we can power off unconnected and
>> suspended external ports.  The hypothesis is that some users may not
>> care about USB device connects and disconnects when their system is
>> idle.  They really will only care that the changes get noticed when
>> they start using their system.
>>
>> This breaks down for some users, of course.  Arjan has several deskt=
ops
>> under his desk that are always on, and he starts interacting with th=
em
>> by plugging in a USB mouse and keyboard.  So obviously the "port pow=
er
>> off on screen blank" policy might not work for him.  It also won't w=
ork
>> for servers, where no one connects a real monitor to the server for
>> months, but server folks probably won't care about this mechanism
>> because their power budget is so much larger.
>>
>> However, someone on an airplane, trying to eek out every mW out of t=
heir
>> battery, would want to power off any external unconnected or suspend=
ed
>> USB ports.
>>
>> The point is that whether a user wants to allow the ports to be powe=
red
>> off should be a userspace policy.  That's why we export the sysfs fi=
le,
>> so that desktop software can implement whatever their customers want=
=2E
>> Personally, I would want a checkbox in the Gnome display settings th=
at
>> says "Power off USB ports on screen blank".
>
> Makes sense.  (But I foresee a lot of confusion among users when this
> box is checked and the ports don't get powered down -- many of
> today's laptops are incapable of powering down their USB ports.)
>
How about to just provide sys files if the usb port can be power off
and the checkbox only is selectable when sys files exit.
>>>> "waiting for connection" state is to avoid device to being removed=
=2E
>>>
>>> Why would the device be removed?
>>
>> When we turn the power back on, we'll get a connect status change bi=
t
>> set.  We don't want the USB core to misinterpret that bit and try to
>> logically disconnect the device attached to the port.
>
> All you have to do is turn off the connect-change status bit.  In fac=
t,
> the debounce routine does this already.  Just leave the port state se=
t
> to "off" until the connection is debounced.
This is my original version. :)
But after testing, I found that after the connection is debounced,
hub_port_connect_change() may not to be invoked or not reach place
"disconnect devices".

hub_port_connect_change() {
=2E..
/* debounce may be completed before here and port's state has becomed
  * "on". The device also will be removed.
  */=09
if (hub->port_data[port1 - 1].power_state =3D=3D USB_PORT_POWER_STATE_O=
=46F) {
	clear_bit(port1, hub->change_bits);
	return;
}
=09
/* Disconnect any existing devices under this port */
if (udev)
	usb_disconnect(&hub->port_data[port1-1].child);
clear_bit(port1, hub->change_bits);

=2E..
}

I spent a lot of time resolving the problem. At last, I found to add
"waiting for connection" state to resolve the problem.

After power on the port, hub_irq() invokes kick_khubd() to deal with
connect or enable change event. Connect debouncing does in the
usb_port_resume() and  connect-change event is processed in hub_thread(=
).
It is hard to synchronize them and the port's state should be set to
"on" after the connect-change event finishing.
>
> You may also have to turn off the enable-change status bit.
>
You mean clear_port_feature(connect or enable change)?
 From my opinion, this will be done in the hub_event() since
hub is active and hub->quiescing should be 0 when the usb_port_resume()
is invoking. Every portIs that right?

>> What if the external device was suspended, we power off the port, an=
d
>> then the user yanks the device while it was suspended?  A device may
>> never connect in that case.
>
> Then the debounce loop in usb_port_wait_for_connected() will time out=
=2E
> At that point you'll know the device has been disconnected.
>
>> Let me know if you have any more questions about the mechanisms or
>> policy we're trying to set up.  Tianyu has been creating these patch=
es,
>> but I've tried to provide some advice to him along the way.
>
> I think I get the picture.  It's a tricky job, because you can easily
> go too far and turn off something that needs to remain on.
This is reason why
>
> Alan Stern
>

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
