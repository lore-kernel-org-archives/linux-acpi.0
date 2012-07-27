From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update
 relevant code
Date: Fri, 27 Jul 2012 12:46:50 +0800
Message-ID: <1343364410.8142.42.camel@linux-s257.site>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
	 <20120726125838.GA28853@growl> <1343357441.8142.18.camel@linux-s257.site>
	 <CADnq5_Mz5cjyYZ=1gjq+iaGtizhckKBL23gLaNJQFAPXHGF4TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:34462 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab2G0Et3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2012 00:49:29 -0400
In-Reply-To: <CADnq5_Mz5cjyYZ=1gjq+iaGtizhckKBL23gLaNJQFAPXHGF4TQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

=E6=96=BC =E5=9B=9B=EF=BC=8C2012-07-26 =E6=96=BC 23:31 -0400=EF=BC=8CAl=
ex Deucher =E6=8F=90=E5=88=B0=EF=BC=9A
> On Thu, Jul 26, 2012 at 10:50 PM, joeyli <jlee@suse.com> wrote:
> > =E6=96=BC =E5=9B=9B=EF=BC=8C2012-07-26 =E6=96=BC 14:58 +0200=EF=BC=8C=
Luca Tettamanti =E6=8F=90=E5=88=B0=EF=BC=9A
> >> - again ACPI video module gets the nodification (in this case
> >>   ACPI_VIDEO_NOTIFY_PROBE), re-enumerated and send KEY_SWITCHVIDEO=
MODE
> >> - KDE seems this and muck with the screen configuration :(
> >> - meanwhile the brightness notification is propagated, the
> >> hypothetical
> >>   radeon driver does its magic to adjust the screen.
> >>
> >> My first idea would be to make ACPI_VIDEO_NOTIFY_PROBE also call t=
o
> >> the
> >> acpi notifier chain, and allow the handlers to veto the key press
> >> (like
> >> it's done for ACPI_VIDEO_NOTIFY_SWITCH).
> >
> > I welcome this approach!
> >
> > On some ATI machine's DSDT also issue ACPI_VIDEO_NOTIFY_PROBE when
> > AC-power unplug, because BIOS want to nodify video driver do some p=
ower
> > saving stuff.
> > It causes KEY_SWITCHVIDEOMODE issued by acpi/video driver when AC-p=
ower
> > unplug.
> >
> > At least acpi/video driver need to know this 0x81 event is filed by=
 BIOS
> > to radeon-acpi for notify but not do video mode switch. That means =
the
> > radeon drm need take the video switch responsibility.
>=20
> Probably we'd just want the radeon acpi handler to just forward the
> events to userspace so that the user can choose what to do with it
> (xrandr command, etc.), otherwise we'll need to define policy in the
> driver.
>=20
> Alex
>=20

Any kernel module can issue KEY_SWITCHVIDEOMODE to user space, then
gnome-settings-daemon(on Gnome) and  krandr(on KDE) will call xrandr
library to switch video mode.


The 0x81 ACPI event for acpi/video driver is ACPI_VIDEO_NOTIFY_PROBE,
means need issue KEY_SWITCHVIDEOMODE. But, 0x81 for radeon is a general
notification event.
I didn't see probe state in GET_SYSTEM_BIOS_REQUESTS, how can we
distinguish this 0x81 is a ACPI_VIDEO_NOTIFY_PROBE or a ATI general
notification event?

+ * flags
+ * bits 1:0:
+ * 0 - Notify(VGA, 0x81) is not used for notification
+ * 1 - Notify(VGA, 0x81) is used for notification

Per the above flags, when we detect bit set to 1, means 0x81 used for r=
adeon-acpi
to be a general notification event. My question is: what's the event nu=
mber for
ACPI_VIDEO_NOTIFY_PROBE on this AMD/ATI machine when 0x81 not available=
 for acpi/video?


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
