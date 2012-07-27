From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update relevant code
Date: Fri, 27 Jul 2012 09:21:11 -0400
Message-ID: <CADnq5_PZoRGAs+cYAA+x3XEDF622xHoMD9msOqvp_XH68Bv_9g@mail.gmail.com>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
	<20120726125838.GA28853@growl>
	<1343357441.8142.18.camel@linux-s257.site>
	<CADnq5_Mz5cjyYZ=1gjq+iaGtizhckKBL23gLaNJQFAPXHGF4TQ@mail.gmail.com>
	<1343364410.8142.42.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61349 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab2G0NVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2012 09:21:12 -0400
Received: by wibhr14 with SMTP id hr14so2957333wib.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jul 2012 06:21:11 -0700 (PDT)
In-Reply-To: <1343364410.8142.42.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Fri, Jul 27, 2012 at 12:46 AM, joeyli <jlee@suse.com> wrote:
> =A9=F3 =A5|=A1A2012-07-26 =A9=F3 23:31 -0400=A1AAlex Deucher =B4=A3=A8=
=EC=A1G
>> On Thu, Jul 26, 2012 at 10:50 PM, joeyli <jlee@suse.com> wrote:
>> > =A9=F3 =A5|=A1A2012-07-26 =A9=F3 14:58 +0200=A1ALuca Tettamanti =B4=
=A3=A8=EC=A1G
>> >> - again ACPI video module gets the nodification (in this case
>> >>   ACPI_VIDEO_NOTIFY_PROBE), re-enumerated and send KEY_SWITCHVIDE=
OMODE
>> >> - KDE seems this and muck with the screen configuration :(
>> >> - meanwhile the brightness notification is propagated, the
>> >> hypothetical
>> >>   radeon driver does its magic to adjust the screen.
>> >>
>> >> My first idea would be to make ACPI_VIDEO_NOTIFY_PROBE also call =
to
>> >> the
>> >> acpi notifier chain, and allow the handlers to veto the key press
>> >> (like
>> >> it's done for ACPI_VIDEO_NOTIFY_SWITCH).
>> >
>> > I welcome this approach!
>> >
>> > On some ATI machine's DSDT also issue ACPI_VIDEO_NOTIFY_PROBE when
>> > AC-power unplug, because BIOS want to nodify video driver do some =
power
>> > saving stuff.
>> > It causes KEY_SWITCHVIDEOMODE issued by acpi/video driver when AC-=
power
>> > unplug.
>> >
>> > At least acpi/video driver need to know this 0x81 event is filed b=
y BIOS
>> > to radeon-acpi for notify but not do video mode switch. That means=
 the
>> > radeon drm need take the video switch responsibility.
>>
>> Probably we'd just want the radeon acpi handler to just forward the
>> events to userspace so that the user can choose what to do with it
>> (xrandr command, etc.), otherwise we'll need to define policy in the
>> driver.
>>
>> Alex
>>
>
> Any kernel module can issue KEY_SWITCHVIDEOMODE to user space, then
> gnome-settings-daemon(on Gnome) and  krandr(on KDE) will call xrandr
> library to switch video mode.
>
>
> The 0x81 ACPI event for acpi/video driver is ACPI_VIDEO_NOTIFY_PROBE,
> means need issue KEY_SWITCHVIDEOMODE. But, 0x81 for radeon is a gener=
al
> notification event.
> I didn't see probe state in GET_SYSTEM_BIOS_REQUESTS, how can we
> distinguish this 0x81 is a ACPI_VIDEO_NOTIFY_PROBE or a ATI general
> notification event?
>
> + * flags
> + * bits 1:0:
> + * 0 - Notify(VGA, 0x81) is not used for notification
> + * 1 - Notify(VGA, 0x81) is used for notification
>
> Per the above flags, when we detect bit set to 1, means 0x81 used for=
 radeon-acpi
> to be a general notification event. My question is: what's the event =
number for
> ACPI_VIDEO_NOTIFY_PROBE on this AMD/ATI machine when 0x81 not availab=
le for acpi/video?
>


+/* ARG0: ATIF_FUNCTION_GET_SYSTEM_PARAMETERS
+ * ARG1: none
+ * OUTPUT:
+ * WORD  - structure size in bytes (includes size field)
+ * DWORD - valid flags mask
+ * DWORD - flags
+ *
+ * OR
+ *
+ * WORD  - structure size in bytes (includes size field)
+ * DWORD - valid flags mask
+ * DWORD - flags
+ * BYTE  - notify command code
+ *
+ * flags
+ * bits 1:0:
+ * 0 - Notify(VGA, 0x81) is not used for notification
+ * 1 - Notify(VGA, 0x81) is used for notification
+ * 2 - Notify(VGA, n) is used for notification where
+ * n (0xd0-0xd9) is specified in notify command code.
+ * bit 2:
+ * 1 - lid changes not reported though int10
+ */

if bits 1:0 =3D=3D 0, there is no notify event for radeon.  When bits 1=
:0
=3D=3D 1, it uses 0x81; when bits 1:0 =3D=3D 2 it uses the event number
specified in the following byte (notify command code) which would be
something in the 0xd0-0xd9 range.

Alex
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
