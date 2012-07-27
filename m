From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update relevant code
Date: Fri, 27 Jul 2012 12:31:09 -0400
Message-ID: <CADnq5_OBQh5mUo__bvygz=0L1n=F3Knwa3NYaL07Ehq4KSA=+Q@mail.gmail.com>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
	<20120726125838.GA28853@growl>
	<1343357441.8142.18.camel@linux-s257.site>
	<CADnq5_Mz5cjyYZ=1gjq+iaGtizhckKBL23gLaNJQFAPXHGF4TQ@mail.gmail.com>
	<1343364410.8142.42.camel@linux-s257.site>
	<CADnq5_PZoRGAs+cYAA+x3XEDF622xHoMD9msOqvp_XH68Bv_9g@mail.gmail.com>
	<1343403127.1788.26.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:62952 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab2G0QbK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2012 12:31:10 -0400
Received: by gglu4 with SMTP id u4so3366310ggl.19
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jul 2012 09:31:09 -0700 (PDT)
In-Reply-To: <1343403127.1788.26.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Fri, Jul 27, 2012 at 11:32 AM, joeyli <jlee@suse.com> wrote:
> =A9=F3 =A4=AD=A1A2012-07-27 =A9=F3 09:21 -0400=A1AAlex Deucher =B4=A3=
=A8=EC=A1G
>> On Fri, Jul 27, 2012 at 12:46 AM, joeyli <jlee@suse.com> wrote:
>> >
>> > + * flags
>> > + * bits 1:0:
>> > + * 0 - Notify(VGA, 0x81) is not used for notification
>> > + * 1 - Notify(VGA, 0x81) is used for notification
>> >
>> > Per the above flags, when we detect bit set to 1, means 0x81 used =
for radeon-acpi
>> > to be a general notification event. My question is: what's the eve=
nt number for
>> > ACPI_VIDEO_NOTIFY_PROBE on this AMD/ATI machine when 0x81 not avai=
lable for acpi/video?
>> >
>>
>>
>> +/* ARG0: ATIF_FUNCTION_GET_SYSTEM_PARAMETERS
>> + * ARG1: none
>> + * OUTPUT:
>> + * WORD  - structure size in bytes (includes size field)
>> + * DWORD - valid flags mask
>> + * DWORD - flags
>> + *
>> + * OR
>> + *
>> + * WORD  - structure size in bytes (includes size field)
>> + * DWORD - valid flags mask
>> + * DWORD - flags
>> + * BYTE  - notify command code
>> + *
>> + * flags
>> + * bits 1:0:
>> + * 0 - Notify(VGA, 0x81) is not used for notification
>> + * 1 - Notify(VGA, 0x81) is used for notification
>> + * 2 - Notify(VGA, n) is used for notification where
>> + * n (0xd0-0xd9) is specified in notify command code.
>> + * bit 2:
>> + * 1 - lid changes not reported though int10
>> + */
>>
>> if bits 1:0 =3D=3D 0, there is no notify event for radeon.  When bit=
s 1:0
>> =3D=3D 1, it uses 0x81; when bits 1:0 =3D=3D 2 it uses the event num=
ber
>> specified in the following byte (notify command code) which would be
>> something in the 0xd0-0xd9 range.
>>
>> Alex
>
> Did you mean every time we received 0x81 event in kernel module, we n=
eed
> access GET_SYSTEM_PARAMETERS to get the flags for distinguish between
> ACPI_VIDEO_NOTIFY_PROBE?
>
> Or just need access ONE time when system boot?

Just once at start up to see what event, if any, the sbios will use to
signal the driver.

>
>
> I have a machine the GET_SYSTEM_PARAMETERS looks like this:
>
> Method (AF01, 0, NotSerialized)                 /* ATIF_FUNCTION_GET_=
SYSTEM_PARAMETERS 0x1 */
> {
>     CreateWordField (ATIB, Zero, SSZE)
>     CreateDWordField (ATIB, 0x02, VMSK)
>     CreateDWordField (ATIB, 0x06, FLGS)         /* flags bits 1:0 */
>     Store (0x0A, SSZE)          /* structure SIZE fixed */
>     Store (0x03, VMSK)          /* valid flags mask fixed to 0x03 */
>     Store (One, FLGS)           /* FLAGS always set to 1 */
>     Return (ATIB)
> }
>
> Looks like just need access ONE time when system boot because those
> return value of AF01 fixed in DSDT.
>
> On this machine doesn't support probe event, I didn't see any event
> issued when I plug D-Sub. Does that means those kind of ATI/AMD machi=
nes
> do NOT support probe notify?

Analog connectors don't support hotplug at all.  And hotplug on
digital connectors is already handled by the driver.  As far as I know
ACPI doesn't provide any events for these.  The driver gets interrupts
directly from the hw.  The only events the sbios uses the notify event
for are the ones listed in the supported notifications mask from
ATIF_FUNCTION_VERIFY_INTERFACE:

+#define ATIF_FUNCTION_VERIFY_INTERFACE                             0x0
+/* ARG0: ATIF_FUNCTION_VERIFY_INTERFACE
+ * ARG1: none
+ * OUTPUT:
+ * WORD  - structure size in bytes (includes size field)
+ * WORD  - version
+ * DWORD - supported notifications mask
+ * DWORD - supported functions bit vector
+ */
+/* Notifications mask */
+#       define ATIF_DISPLAY_SWITCH_REQUEST_SUPPORTED               (1 =
<< 0)
+#       define ATIF_EXPANSION_MODE_CHANGE_REQUEST_SUPPORTED        (1 =
<< 1)
+#       define ATIF_THERMAL_STATE_CHANGE_REQUEST_SUPPORTED         (1 =
<< 2)
+#       define ATIF_FORCED_POWER_STATE_CHANGE_REQUEST_SUPPORTED    (1 =
<< 3)
+#       define ATIF_SYSTEM_POWER_SOURCE_CHANGE_REQUEST_SUPPORTED   (1 =
<< 4)
+#       define ATIF_DISPLAY_CONF_CHANGE_REQUEST_SUPPORTED          (1 =
<< 5)
+#       define ATIF_PX_GFX_SWITCH_REQUEST_SUPPORTED                (1 =
<< 6)
+#       define ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST_SUPPORTED      (1 =
<< 7)
+#       define ATIF_DGPU_DISPLAY_EVENT_SUPPORTED                   (1 =
<< 8)


They are things like the user presses the display switch hotkey or
presses the brightness up hotkey.

Alex
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
