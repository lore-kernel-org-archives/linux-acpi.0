From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update
 relevant code
Date: Fri, 27 Jul 2012 10:50:41 +0800
Message-ID: <1343357441.8142.18.camel@linux-s257.site>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
	 <20120726125838.GA28853@growl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54455 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab2G0DNW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jul 2012 23:13:22 -0400
In-Reply-To: <20120726125838.GA28853@growl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: alexdeucher@gmail.com, airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

=E6=96=BC =E5=9B=9B=EF=BC=8C2012-07-26 =E6=96=BC 14:58 +0200=EF=BC=8CLu=
ca Tettamanti =E6=8F=90=E5=88=B0=EF=BC=9A
> - again ACPI video module gets the nodification (in this case
>   ACPI_VIDEO_NOTIFY_PROBE), re-enumerated and send KEY_SWITCHVIDEOMOD=
E
> - KDE seems this and muck with the screen configuration :(
> - meanwhile the brightness notification is propagated, the
> hypothetical
>   radeon driver does its magic to adjust the screen.
>=20
> My first idea would be to make ACPI_VIDEO_NOTIFY_PROBE also call to
> the
> acpi notifier chain, and allow the handlers to veto the key press
> (like
> it's done for ACPI_VIDEO_NOTIFY_SWITCH).=20

I welcome this approach!

On some ATI machine's DSDT also issue ACPI_VIDEO_NOTIFY_PROBE when
AC-power unplug, because BIOS want to nodify video driver do some power
saving stuff.
It causes KEY_SWITCHVIDEOMODE issued by acpi/video driver when AC-power
unplug.

At least acpi/video driver need to know this 0x81 event is filed by BIO=
S
to radeon-acpi for notify but not do video mode switch. That means the
radeon drm need take the video switch responsibility.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
